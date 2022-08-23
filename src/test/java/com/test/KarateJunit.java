package com.test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.apache.commons.io.FileUtils;
import static org.junit.Assert.*;
import org.junit.Test;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class KarateJunit {

    @Test
    public void testParallel() {
        Results results = Runner
            .path("src/test/resources")
            .outputCucumberJson(true)
            .parallel(5);

        generateReport(results.getReportDir());
        assertTrue("there are scenario failures", results.getFailCount() == 0);
        //assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
    
    private static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.removeIf(file->file.length()==0);
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "User Blog Report");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();        
    }
	
}
