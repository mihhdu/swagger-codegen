package io.swagger.codegen.languages;

import io.swagger.codegen.*;
import io.swagger.models.properties.ArrayProperty;
import io.swagger.models.properties.MapProperty;
import io.swagger.models.properties.Property;
import io.swagger.models.parameters.Parameter;

import java.io.File;
import java.util.*;

import org.apache.commons.lang3.StringUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CsharpActivityClientCodegen extends CSharpClientCodegen {
    public static final String PROJECT_NAME = "projectName";

    static Logger LOGGER = LoggerFactory.getLogger(CsharpActivityClientCodegen.class);

    public CodegenType getTag() {
        return CodegenType.CLIENT;
    }

    public String getName() {
        return "csharp-activity";
    }

    public String getHelp() {
        return "Generates a csharp activity client.";
    }

    public CsharpActivityClientCodegen() {
        super();
        netCoreProjectFileFlag = true;
    }

    public void processOpts() {
        super.processOpts();
        supportingFiles.add(new SupportingFile("IActivity.mustache", "", "IActivities.json"));
    }
}
