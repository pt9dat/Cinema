import io.appium.java_client.MobileElement;
import io.appium.java_client.ios.IOSDriver;
import io.appium.java_client.pagefactory.AppiumFieldDecorator;
import io.appium.java_client.remote.HideKeyboardStrategy;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.concurrent.TimeUnit;



public class SignIn {
    @FindBy(id = "taophim_btn")
    MobileElement taoPhimBtn;

    @FindBy(id = "email_tf")
    MobileElement emailTF;

    @FindBy(id = "pass_tf")
    MobileElement passTF;

    @FindBy(id = "login_btn")
    MobileElement loginBtn;

    @FindBy(id = "register_btn")
    MobileElement registerBtn;

    @FindBy(id = "dang_nhap_lbl")
    MobileElement dangNhapLbl;

    @FindBy(id = "dk_user_name_tf")
    MobileElement dkUserNameTF;

    @FindBy(id = "dk_email_tf")
    MobileElement dkEmailTF;

    @FindBy(id = "dk_pass_tf")
    MobileElement dkPassTF;

    @FindBy(id = "dk_confirm_pass_tf")
    MobileElement dkConfirmPassTF;

    @FindBy(id = "dk_signup_btn")
    MobileElement dkSignUpBtn;

    @FindBy(id = "dk_signin_btn")
    MobileElement dkSignInBtn;

    @FindBy(id = "user_info_btn")
    MobileElement userInfoBtn;

    @FindBy(id = "signout_btn")
    MobileElement signOutBtn;

    @FindBy(id = "dk_hide_kb_btn")
    MobileElement dkHideKbBtn;

    @FindBy(id = "dn_hide_kb_btn")
    MobileElement dnHideKbBtn;

    private IOSDriver iosDriver;
    private WebDriverWait wait;

    String userName = "dat4444";
    String email = "dat4444@mail.com";
    String pass = "4444";


    public SignIn(IOSDriver iosDriver) {
        this.iosDriver = iosDriver;
        PageFactory.initElements(new AppiumFieldDecorator(iosDriver, 30, TimeUnit.SECONDS), this);
        this.wait = new WebDriverWait(iosDriver, 30);

    }

    public void testSignIn () {
        taoPhimBtn.click();
        iosDriver.switchTo().alert().accept();

        registerBtn.click();

        dkUserNameTF.sendKeys(userName);
        dkEmailTF.sendKeys(email);
        dkPassTF.sendKeys(pass);
        dkConfirmPassTF.sendKeys(pass);
        dkHideKbBtn.click();
        dkSignUpBtn.click();

        userInfoBtn.click();

        signOutBtn.click();
        iosDriver.switchTo().alert().accept();

        emailTF.sendKeys(email);
        passTF.sendKeys(pass);
        dnHideKbBtn.click();
        loginBtn.click();
    }

}

