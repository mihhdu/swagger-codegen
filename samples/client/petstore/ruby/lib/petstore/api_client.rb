require 'date'
require 'json'
require 'logger'
require 'tempfile'
require 'typhoeus'
require 'uri'

module Petstore
  class ApiClient
    attr_accessor :scheme, :host, :base_path, :user_agent

    # Defines the username used with HTTP basic authentication.
    #
    # @return [String]
    attr_accessor :username

    # Defines the password used with HTTP basic authentication.
    #
    # @return [String]
    attr_accessor :password

    # Defines API keys used with API Key authentications.
    #
    # @return [Hash] key: parameter name, value: parameter value (API key)
    #
    # @example parameter name is "api_key", API key is "xxx" (e.g. "api_key=xxx" in query string)
    #   config.api_key['api_key'] = 'xxx'
    attr_accessor :api_key

    # Defines API key prefixes used with API Key authentications.
    #
    # @return [Hash] key: parameter name, value: API key prefix
    #
    # @example parameter name is "Authorization", API key prefix is "Token" (e.g. "Authorization: Token xxx" in headers)
    #   config.api_key_prefix['api_key'] = 'Token'
    attr_accessor :api_key_prefix

    # Set this to false to skip verifying SSL certificate when calling API from https server.
    # Default to true.
    #
    # @note Do NOT set it to false in production code, otherwise you would face multiple types of cryptographic attacks.
    #
    # @return [true, false]
    attr_accessor :verify_ssl

    # Set this to customize the certificate file to verify the peer.
    #
    # @return [String] the path to the certificate file
    #
    # @see The `cainfo` option of Typhoeus, `--cert` option of libcurl. Related source code:
    # https://github.com/typhoeus/typhoeus/blob/master/lib/typhoeus/easy_factory.rb#L145
    attr_accessor :ssl_ca_cert

    # Set this to enable/disable debugging. When enabled (set to true), HTTP request/response
    # details will be logged with `logger.debug` (see the `logger` attribute).
    # Default to false.
    #
    # @return [true, false]
    attr_accessor :debugging

    # Defines the logger used for debugging.
    # Default to `Rails.logger` (when in Rails) or logging to STDOUT.
    #
    # @return [#debug]
    attr_accessor :logger

    # Defines the temporary folder to store downloaded files
    # (for API endpoints that have file response).
    # Default to use `Tempfile`.
    #
    # @return [String]
    attr_accessor :temp_folder_path

    # Defines the headers to be used in HTTP requests of all API calls by default.
    #
    # @return [Hash]
    attr_accessor :default_headers

    # Stores the HTTP response from the last API call using this API client.
    attr_accessor :last_response

    # The constructor accepts a optional block to configure the API client.
    #
    # @example
    #   Petstore::ApiClient.new do |client|
    #     client.api_key['api_key'] = 'your key' # api key authentication
    #     client.username = 'your username'      # username for http basic authentication
    #     client.password = 'your password'      # password for http basic authentication
    #   end
    def initialize(&block)
      @format = 'json'
      @scheme = 'http'
      @host = 'petstore.swagger.io'
      @base_path = '/v2'
      @user_agent = "ruby-swagger-#{VERSION}"
      @inject_format = false
      @force_ending_format = false

      @default_headers = {
        'Content-Type' => "application/#{@format.downcase}",
        'User-Agent' => @user_agent
      }

      # keys for API key authentication (param-name => api-key)
      @api_key = {}
      @api_key_prefix = {}

      @verify_ssl = true

      @debugging = false
      @logger = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)

      configure(&block)
    end

    # Default API client.
    def self.default
      @@default ||= ApiClient.new
    end

    # Call this method to modify defaults in your initializers.
    def configure
      yield(self) if block_given?

      # remove :// from scheme
      @scheme.sub!(/:\/\//, '')

      # remove http(s):// and anything after a slash
      @host.sub!(/https?:\/\//, '')
      @host = @host.split('/').first

      # Add leading and trailing slashes to base_path
      @base_path = "/#{@base_path}".gsub(/\/+/, '/')
      @base_path = "" if @base_path == "/"
    end

    def call_api(http_method, path, opts = {})
      request = build_request(http_method, path, opts)
      response = request.run

      # record as last response
      @last_response = response

      if debugging
        logger.debug "HTTP response body ~BEGIN~\n#{response.body}\n~END~\n"
      end

      unless response.success?
        fail ApiError.new(:code => response.code,
                          :response_headers => response.headers,
                          :response_body => response.body),
             response.status_message
      end

      if opts[:return_type]
        return deserialize(response, opts[:return_type])
      else
        return nil
      end
    end

    def build_request(http_method, path, opts = {})
      url = build_request_url(path)
      http_method = http_method.to_sym.downcase

      header_params = @default_headers.merge(opts[:header_params] || {})
      query_params = opts[:query_params] || {}
      form_params = opts[:form_params] || {}

      
      update_params_for_auth! header_params, query_params, opts[:auth_names]
      

      req_opts = {
        :method => http_method,
        :headers => header_params,
        :params => query_params,
        :ssl_verifypeer => @verify_ssl,
        :cainfo => @ssl_ca_cert,
        :verbose => @debugging
      }

      if [:post, :patch, :put, :delete].include?(http_method)
        req_body = build_request_body(header_params, form_params, opts[:body])
        req_opts.update :body => req_body
        if debugging
          logger.debug "HTTP request body param ~BEGIN~\n#{req_body}\n~END~\n"
        end
      end

      Typhoeus::Request.new(url, req_opts)
    end

    # Deserialize the response to the given return type.
    #
    # @param [String] return_type some examples: "User", "Array[User]", "Hash[String,Integer]"
    def deserialize(response, return_type)
      body = response.body
      return nil if body.nil? || body.empty?

      # handle file downloading - save response body into a tmp file and return the File instance
      return download_file(response) if return_type == 'File'

      # ensuring a default content type
      content_type = response.headers['Content-Type'] || 'application/json'

      unless content_type.start_with?('application/json')
        fail "Content-Type is not supported: #{content_type}"
      end

      begin
        data = JSON.parse("[#{body}]", :symbolize_names => true)[0]
      rescue JSON::ParserError => e
        if %w(String Date DateTime).include?(return_type)
          data = body
        else
          raise e
        end
      end

      convert_to_type data, return_type
    end

    # Convert data to the given return type.
    def convert_to_type(data, return_type)
      return nil if data.nil?
      case return_type
      when 'String'
        data.to_s
      when 'Integer'
        data.to_i
      when 'Float'
        data.to_f
      when 'BOOLEAN'
        data == true
      when 'DateTime'
        # parse date time (expecting ISO 8601 format)
        DateTime.parse data
      when 'Date'
        # parse date time (expecting ISO 8601 format)
        Date.parse data
      when 'Object'
        # generic object, return directly
        data
      when /\AArray<(.+)>\z/
        # e.g. Array<Pet>
        sub_type = $1
        data.map {|item| convert_to_type(item, sub_type) }
      when /\AHash\<String, (.+)\>\z/
        # e.g. Hash<String, Integer>
        sub_type = $1
        {}.tap do |hash|
          data.each {|k, v| hash[k] = convert_to_type(v, sub_type) }
        end
      else
        # models, e.g. Pet
        Petstore.const_get(return_type).new.tap do |model|
          model.build_from_hash data
        end
      end
    end

    # Save response body into a file in (the defined) temporary folder, using the filename
    # from the "Content-Disposition" header if provided, otherwise a random filename.
    #
    # @see Configuration#temp_folder_path
    # @return [File] the file downloaded
    def download_file(response)
      tmp_file = Tempfile.new '', @temp_folder_path
      content_disposition = response.headers['Content-Disposition']
      if content_disposition
        filename = content_disposition[/filename=['"]?([^'"\s]+)['"]?/, 1]
        path = File.join File.dirname(tmp_file), filename
      else
        path = tmp_file.path
      end
      # close and delete temp file
      tmp_file.close!

      File.open(path, 'w') { |file| file.write(response.body) }
      logger.info "File written to #{path}. Please move the file to a proper folder for further processing and delete the temp afterwards"
      return File.new(path)
    end

    def build_request_url(path)
      url = [host, base_path, path].join('/').gsub(/\/+/, '/')
      url = "#{scheme}://#{url}"
      URI.encode(url)
    end

    def build_request_body(header_params, form_params, body)
      # http form
      if header_params['Content-Type'] == 'application/x-www-form-urlencoded' ||
          header_params['Content-Type'] == 'multipart/form-data'
        data = form_params.dup
        data.each do |key, value|
          data[key] = value.to_s if value && !value.is_a?(File)
        end
      elsif body
        data = body.is_a?(String) ? body : body.to_json
      else
        data = nil
      end
      return data
    end

    
    # Update hearder and query params based on authentication settings.
    def update_params_for_auth!(header_params, query_params, auth_names)
      return unless auth_names
      auth_names.each do |auth_name|
        case auth_name
        when 'api_key'
          header_params ||= {}
          header_params['api_key'] = get_api_key_with_prefix('api_key')
        when 'petstore_auth'
          # TODO: support oauth
        
        end
      end
    end

    # Get API key (with prefix if set).
    # @param [String] param_name the parameter name of API key auth
    def get_api_key_with_prefix(param_name)
      if @api_key_prefix[param_name]
        "#{@api_key_prefix[param_name]} #{@api_key[param_name]}"
      else
        @api_key[param_name]
      end
    end
    

    def user_agent=(user_agent)
      @user_agent = user_agent
      @default_headers['User-Agent'] = @user_agent
    end

    # Return Accept header based on an array of accepts provided.
    # @param [Array] accepts array for Accept
    # @return [String] the Accept header (e.g. application/json)
    def select_header_accept(accepts)
      if accepts.empty?
        return
      elsif accepts.any?{ |s| s.casecmp('application/json') == 0 }
        'application/json' # look for json data by default
      else
        accepts.join(',')
      end
    end

    # Return Content-Type header based on an array of content types provided.
    # @param [Array] content_types array for Content-Type
    # @return [String] the Content-Type header  (e.g. application/json)
    def select_header_content_type(content_types)
      if content_types.empty?
        'application/json' # use application/json by default
      elsif content_types.any?{ |s| s.casecmp('application/json')==0 }
        'application/json' # use application/json if it's included
      else
        content_types[0] # otherwise, use the first one
      end
    end

    # Convert object (array, hash, object, etc) to JSON string.
    # @param [Object] model object to be converted into JSON string
    # @return [String] JSON string representation of the object
    def object_to_http_body(model)
      return if model.nil?
      _body = nil
      if model.is_a?(Array)
        _body = model.map{|m| object_to_hash(m) }
      else
        _body = object_to_hash(model)
      end
      _body.to_json
    end

    # Convert object(non-array) to hash.
    # @param [Object] obj object to be converted into JSON string
    # @return [String] JSON string representation of the object
    def object_to_hash(obj)
      if obj.respond_to?(:to_hash)
        obj.to_hash
      else
        obj
      end
    end
  end
end
