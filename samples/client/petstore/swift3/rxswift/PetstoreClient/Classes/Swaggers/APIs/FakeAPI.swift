//
// FakeAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift


open class FakeAPI: APIBase {
    /**
     - parameter body: (body) Input boolean as post body (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func fakeOuterBooleanSerialize(body: Bool? = nil, completion: @escaping ((_ data: OuterBoolean?, _ error: ErrorResponse?) -> Void)) {
        fakeOuterBooleanSerializeWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - parameter body: (body) Input boolean as post body (optional)
     - returns: Observable<OuterBoolean>
     */
    open class func fakeOuterBooleanSerialize(body: Bool? = nil) -> Observable<OuterBoolean> {
        return Observable.create { observer -> Disposable in
            fakeOuterBooleanSerialize(body: body) { data, error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - POST /fake/outer/boolean
     - Test serialization of outer boolean types

     - examples: [{contentType=application/json, example=true}]
     - parameter body: (body) Input boolean as post body (optional)
     - returns: RequestBuilder<OuterBoolean> 
     */
    open class func fakeOuterBooleanSerializeWithRequestBuilder(body: Bool? = nil) -> RequestBuilder<OuterBoolean> {
        let path = "/fake/outer/boolean"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body?.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<OuterBoolean>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     - parameter body: (body) Input composite as post body (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func fakeOuterCompositeSerialize(body: OuterComposite? = nil, completion: @escaping ((_ data: OuterComposite?, _ error: ErrorResponse?) -> Void)) {
        fakeOuterCompositeSerializeWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - parameter body: (body) Input composite as post body (optional)
     - returns: Observable<OuterComposite>
     */
    open class func fakeOuterCompositeSerialize(body: OuterComposite? = nil) -> Observable<OuterComposite> {
        return Observable.create { observer -> Disposable in
            fakeOuterCompositeSerialize(body: body) { data, error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - POST /fake/outer/composite
     - Test serialization of object with outer number type

     - examples: [{contentType=application/json, example={
  "my_string" : "my_string",
  "my_number" : 0.8008281904610115,
  "my_boolean" : true
}}]
     - parameter body: (body) Input composite as post body (optional)
     - returns: RequestBuilder<OuterComposite> 
     */
    open class func fakeOuterCompositeSerializeWithRequestBuilder(body: OuterComposite? = nil) -> RequestBuilder<OuterComposite> {
        let path = "/fake/outer/composite"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body?.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<OuterComposite>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     - parameter body: (body) Input number as post body (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func fakeOuterNumberSerialize(body: BigDecimal? = nil, completion: @escaping ((_ data: OuterNumber?, _ error: ErrorResponse?) -> Void)) {
        fakeOuterNumberSerializeWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - parameter body: (body) Input number as post body (optional)
     - returns: Observable<OuterNumber>
     */
    open class func fakeOuterNumberSerialize(body: BigDecimal? = nil) -> Observable<OuterNumber> {
        return Observable.create { observer -> Disposable in
            fakeOuterNumberSerialize(body: body) { data, error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - POST /fake/outer/number
     - Test serialization of outer number types

     - examples: [{contentType=application/json, example=0.8008281904610115}]
     - parameter body: (body) Input number as post body (optional)
     - returns: RequestBuilder<OuterNumber> 
     */
    open class func fakeOuterNumberSerializeWithRequestBuilder(body: BigDecimal? = nil) -> RequestBuilder<OuterNumber> {
        let path = "/fake/outer/number"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body?.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<OuterNumber>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     - parameter body: (body) Input string as post body (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func fakeOuterStringSerialize(body: String? = nil, completion: @escaping ((_ data: OuterString?, _ error: ErrorResponse?) -> Void)) {
        fakeOuterStringSerializeWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     - parameter body: (body) Input string as post body (optional)
     - returns: Observable<OuterString>
     */
    open class func fakeOuterStringSerialize(body: String? = nil) -> Observable<OuterString> {
        return Observable.create { observer -> Disposable in
            fakeOuterStringSerialize(body: body) { data, error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     - POST /fake/outer/string
     - Test serialization of outer string types

     - examples: [{contentType=application/json, example=""}]
     - parameter body: (body) Input string as post body (optional)
     - returns: RequestBuilder<OuterString> 
     */
    open class func fakeOuterStringSerializeWithRequestBuilder(body: String? = nil) -> RequestBuilder<OuterString> {
        let path = "/fake/outer/string"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body?.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<OuterString>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     To test \"client\" model
     - parameter body: (body) client model 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func testClientModel(body: Client, completion: @escaping ((_ data: Client?, _ error: ErrorResponse?) -> Void)) {
        testClientModelWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     To test \"client\" model
     - parameter body: (body) client model 
     - returns: Observable<Client>
     */
    open class func testClientModel(body: Client) -> Observable<Client> {
        return Observable.create { observer -> Disposable in
            testClientModel(body: body) { data, error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     To test \"client\" model
     - PATCH /fake
     - To test \"client\" model

     - examples: [{contentType=application/json, example={
  "client" : "client"
}}]
     - parameter body: (body) client model 
     - returns: RequestBuilder<Client> 
     */
    open class func testClientModelWithRequestBuilder(body: Client) -> RequestBuilder<Client> {
        let path = "/fake"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Client>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PATCH", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Fake endpoint for testing various parameters 假端點 偽のエンドポイント 가짜 엔드 포인트 
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func testEndpointParameters(body: Any, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        testEndpointParametersWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error)
        }
    }

    /**
     Fake endpoint for testing various parameters 假端點 偽のエンドポイント 가짜 엔드 포인트 
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func testEndpointParameters(body: Any) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            testEndpointParameters(body: body) { error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next())
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Fake endpoint for testing various parameters 假端點 偽のエンドポイント 가짜 엔드 포인트 
     - POST /fake
     - Fake endpoint for testing various parameters 假端點 偽のエンドポイント 가짜 엔드 포인트 
     - BASIC:
       - type: http
       - name: http_basic_test
     - parameter body: (body)  
     - returns: RequestBuilder<Void> 
     */
    open class func testEndpointParametersWithRequestBuilder(body: Any) -> RequestBuilder<Void> {
        let path = "/fake"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     * enum for parameter enumHeaderStringArray
     */
    public enum EnumHeaderStringArray_testEnumParameters: String { 
        case greaterThan = ">"
        case dollar = "$"
    }

    /**
     * enum for parameter enumHeaderString
     */
    public enum EnumHeaderString_testEnumParameters: String { 
        case abc = "_abc"
        case efg = "-efg"
        case xyz = "(xyz)"
    }

    /**
     * enum for parameter enumQueryStringArray
     */
    public enum EnumQueryStringArray_testEnumParameters: String { 
        case greaterThan = ">"
        case dollar = "$"
    }

    /**
     * enum for parameter enumQueryString
     */
    public enum EnumQueryString_testEnumParameters: String { 
        case abc = "_abc"
        case efg = "-efg"
        case xyz = "(xyz)"
    }

    /**
     * enum for parameter enumQueryInteger
     */
    public enum EnumQueryInteger_testEnumParameters: Int32 { 
        case _1 = 1
        case number2 = -2
    }

    /**
     To test enum parameters
     - parameter body: (body)  (optional)
     - parameter enumHeaderStringArray: (header) Header parameter enum test (string array) (optional)
     - parameter enumHeaderString: (header) Header parameter enum test (string) (optional)
     - parameter enumQueryStringArray: (query) Query parameter enum test (string array) (optional)
     - parameter enumQueryString: (query) Query parameter enum test (string) (optional)
     - parameter enumQueryInteger: (query) Query parameter enum test (double) (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func testEnumParameters(body: Any? = nil, enumHeaderStringArray: [String]? = nil, enumHeaderString: EnumHeaderString_testEnumParameters? = nil, enumQueryStringArray: [String]? = nil, enumQueryString: EnumQueryString_testEnumParameters? = nil, enumQueryInteger: EnumQueryInteger_testEnumParameters? = nil, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        testEnumParametersWithRequestBuilder(body: body, enumHeaderStringArray: enumHeaderStringArray, enumHeaderString: enumHeaderString, enumQueryStringArray: enumQueryStringArray, enumQueryString: enumQueryString, enumQueryInteger: enumQueryInteger).execute { (response, error) -> Void in
            completion(error)
        }
    }

    /**
     To test enum parameters
     - parameter body: (body)  (optional)
     - parameter enumHeaderStringArray: (header) Header parameter enum test (string array) (optional)
     - parameter enumHeaderString: (header) Header parameter enum test (string) (optional)
     - parameter enumQueryStringArray: (query) Query parameter enum test (string array) (optional)
     - parameter enumQueryString: (query) Query parameter enum test (string) (optional)
     - parameter enumQueryInteger: (query) Query parameter enum test (double) (optional)
     - returns: Observable<Void>
     */
    open class func testEnumParameters(body: Any? = nil, enumHeaderStringArray: [String]? = nil, enumHeaderString: EnumHeaderString_testEnumParameters? = nil, enumQueryStringArray: [String]? = nil, enumQueryString: EnumQueryString_testEnumParameters? = nil, enumQueryInteger: EnumQueryInteger_testEnumParameters? = nil) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            testEnumParameters(body: body, enumHeaderStringArray: enumHeaderStringArray, enumHeaderString: enumHeaderString, enumQueryStringArray: enumQueryStringArray, enumQueryString: enumQueryString, enumQueryInteger: enumQueryInteger) { error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next())
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     To test enum parameters
     - GET /fake
     - To test enum parameters

     - parameter body: (body)  (optional)
     - parameter enumHeaderStringArray: (header) Header parameter enum test (string array) (optional)
     - parameter enumHeaderString: (header) Header parameter enum test (string) (optional)
     - parameter enumQueryStringArray: (query) Query parameter enum test (string array) (optional)
     - parameter enumQueryString: (query) Query parameter enum test (string) (optional)
     - parameter enumQueryInteger: (query) Query parameter enum test (double) (optional)
     - returns: RequestBuilder<Void> 
     */
    open class func testEnumParametersWithRequestBuilder(body: Any? = nil, enumHeaderStringArray: [String]? = nil, enumHeaderString: EnumHeaderString_testEnumParameters? = nil, enumQueryStringArray: [String]? = nil, enumQueryString: EnumQueryString_testEnumParameters? = nil, enumQueryInteger: EnumQueryInteger_testEnumParameters? = nil) -> RequestBuilder<Void> {
        let path = "/fake"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body?.encodeToJSON()
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
                        "enum_query_string_array": enumQueryStringArray,
                        "enum_query_string": enumQueryString?.rawValue,
                        "enum_query_integer": enumQueryInteger?.rawValue
        ])
        let nillableHeaders: [String: Any?] = [
                        "enum_header_string_array": enumHeaderStringArray,
                        "enum_header_string": enumHeaderString?.rawValue
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)

        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true, headers: headerParameters)
    }

    /**
     test inline additionalProperties
     - parameter body: (body) request body 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func testInlineAdditionalProperties(body: [String:String], completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        testInlineAdditionalPropertiesWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error)
        }
    }

    /**
     test inline additionalProperties
     - parameter body: (body) request body 
     - returns: Observable<Void>
     */
    open class func testInlineAdditionalProperties(body: [String:String]) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            testInlineAdditionalProperties(body: body) { error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next())
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     test inline additionalProperties
     - POST /fake/inline-additionalProperties

     - parameter body: (body) request body 
     - returns: RequestBuilder<Void> 
     */
    open class func testInlineAdditionalPropertiesWithRequestBuilder(body: [String:String]) -> RequestBuilder<Void> {
        let path = "/fake/inline-additionalProperties"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     test json serialization of form data
     - parameter body: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func testJsonFormData(body: Any, completion: @escaping ((_ error: ErrorResponse?) -> Void)) {
        testJsonFormDataWithRequestBuilder(body: body).execute { (response, error) -> Void in
            completion(error)
        }
    }

    /**
     test json serialization of form data
     - parameter body: (body)  
     - returns: Observable<Void>
     */
    open class func testJsonFormData(body: Any) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            testJsonFormData(body: body) { error in
                if let error = error {
                    observer.on(.error(error as Error))
                } else {
                    observer.on(.next())
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     test json serialization of form data
     - GET /fake/jsonFormData

     - parameter body: (body)  
     - returns: RequestBuilder<Void> 
     */
    open class func testJsonFormDataWithRequestBuilder(body: Any) -> RequestBuilder<Void> {
        let path = "/fake/jsonFormData"
        let URLString = PetstoreClientAPI.basePath + path
        let parameters = body.encodeToJSON()

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = PetstoreClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
