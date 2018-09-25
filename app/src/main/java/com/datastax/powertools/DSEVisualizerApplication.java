package com.datastax.powertools;

import com.datastax.powertools.managed.Dse;
import com.datastax.powertools.resources.DSEVisualizerResource;
import io.dropwizard.Application;
import io.dropwizard.assets.AssetsBundle;
import io.dropwizard.configuration.EnvironmentVariableSubstitutor;
import io.dropwizard.configuration.SubstitutingSourceProvider;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import java.util.EnumSet;
import javax.servlet.DispatcherType;
import javax.servlet.FilterRegistration;
import org.eclipse.jetty.servlets.CrossOriginFilter;

/**
 * Created by sebastianestevez on 3/26/18.
 */
public class DSEVisualizerApplication extends Application<DSEVisualizerConfig> {

    public static void main(String[] args) throws Exception{
        new DSEVisualizerApplication().run(args);
    }

    @Override
    public void initialize(Bootstrap<DSEVisualizerConfig> bootstrap) {

        bootstrap.addBundle(new AssetsBundle("/assets/","/", "index.html"));

        // Enable variable substitution with environment variables
        bootstrap.setConfigurationSourceProvider(
                new SubstitutingSourceProvider(bootstrap.getConfigurationSourceProvider(),
                        new EnvironmentVariableSubstitutor(false)
                )
        );

        super.initialize(bootstrap);
    }

    public void run(DSEVisualizerConfig DSEVisualizerConfig, Environment environment) throws Exception {

        Dse dse = new Dse(DSEVisualizerConfig);
        dse.start();

        // Enable CORS for npm dev mode
        final FilterRegistration.Dynamic cors = environment.servlets()
                .addFilter("cors", CrossOriginFilter.class);
        cors.setInitParameter("allowedOrigins", "*");
        cors.setInitParameter("allowedHeaders", "X-Requested-With,authorization,Content-Type,Accept,Origin");
        cors.setInitParameter("allowedMethods", "OPTIONS,GET,PUT,POST,DELETE,HEAD");

        cors.addMappingForUrlPatterns(EnumSet.allOf(DispatcherType.class), true,
                "/*");


        DSEVisualizerResource DSEVisualizerResource = new DSEVisualizerResource(dse, DSEVisualizerConfig);
        environment.jersey().register(DSEVisualizerResource);
    }
}
