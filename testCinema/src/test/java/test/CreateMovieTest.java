package test;

import base.CreateMovie;
import io.appium.java_client.ios.IOSDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.net.MalformedURLException;
import java.net.URL;

public class CreateMovieTest {
    IOSDriver iosDriver;
    DesiredCapabilities desiredCapabilities = new DesiredCapabilities();
    Integer testResult = 1;

    @BeforeMethod
    public void setUp() throws MalformedURLException {
        testResult = 1;
        desiredCapabilities.setCapability("deviceName", "iPhone 8");
        desiredCapabilities.setCapability("platformName", "iOS");
        desiredCapabilities.setCapability("automationName", "XCUITest");
        desiredCapabilities.setCapability("platformVersion", "11.4");
        desiredCapabilities.setCapability("app", "/Users/chinhdat/Desktop/Cinema.app/");

        iosDriver = new IOSDriver(new URL("http://127.0.0.1:4723/wd/hub"), desiredCapabilities);
//        desiredCapabilities.setCapability(“autoAcceptAlerts”, true);
    }

    @AfterMethod
    public void tearDown() {
        iosDriver.quit();
    }

    @Test
    public void CreateMovieTest() {
        CreateMovie createMovie = new CreateMovie(iosDriver);
        createMovie.testCreateMovie();

        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
