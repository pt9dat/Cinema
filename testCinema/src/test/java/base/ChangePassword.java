package base;

import io.appium.java_client.MobileElement;
import io.appium.java_client.ios.IOSDriver;
import io.appium.java_client.pagefactory.AppiumFieldDecorator;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.concurrent.TimeUnit;

public class ChangePassword {
    @FindBy(id = "mh_taophim_btn")
    MobileElement mhTaoPhimBtn;

    @FindBy(id = "email_tf")
    MobileElement emailTF;

    @FindBy(id = "pass_tf")
    MobileElement passTF;

    @FindBy(id = "login_btn")
    MobileElement loginBtn;

    @FindBy(id = "dang_nhap_lbl")
    MobileElement dangNhapLbl;

    @FindBy(id = "dn_hide_kb_btn")
    MobileElement dnHideKbBtn;

    @FindBy(id = "chon_anh_btn")
    MobileElement chonAnhBtn;

    @FindBy(id = "ten_phim_tf")
    MobileElement tenPhimTF;

    @FindBy(id = "the_loai_tf")
    MobileElement theLoaiTF;

    @FindBy(id = "ngay_phat_hanh_tf")
    MobileElement ngayPhatHanhTF;

    @FindBy(id = "mota_tv")
    MobileElement moTaTV;

    @FindBy(id = "the_loai_picker")
    MobileElement theLoaiPicker;

    @FindBy(id = "tao_phim_btn")
    MobileElement taoPhimBtn;

    @FindBy(id = "mhtp_hide_kb_btn")
    MobileElement hideKbBtn;

    @FindBy(id = "phim_cell_1")
    MobileElement phimCell1;

    @FindBy(id = "cell_ten_phim_lbl")
    MobileElement cellTenPhimLbl;

    @FindBy(id = "cell_nguoi_tao_lbl")
    MobileElement cellNguoiTaoLbl;

    @FindBy(id = "xoa_phim_btn")
    MobileElement xoaPhimBtn;

    @FindBy(id = "user_info_btn")
    MobileElement userInfoBtn;

    @FindBy(id = "doi_pass_btn")
    MobileElement doiPassBtn;

    private IOSDriver iosDriver;
    private WebDriverWait wait;

    String email = "dat2222@mail.com";
    String pass = "1111";
    String title = "dat phim 16";


    public ChangePassword(IOSDriver iosDriver) {
        this.iosDriver = iosDriver;
        PageFactory.initElements(new AppiumFieldDecorator(iosDriver, 30, TimeUnit.SECONDS), this);
        this.wait = new WebDriverWait(iosDriver, 30);

    }

    public void testChangePassword() {
        mhTaoPhimBtn.click();
        iosDriver.switchTo().alert().accept();

        emailTF.sendKeys(email);
        passTF.sendKeys(pass);
        dnHideKbBtn.click();
        loginBtn.click();

        userInfoBtn.click();

        doiPassBtn.click();

        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        iosDriver.findElementByXPath("//XCUIElementTypeAlert[@name=\"Đổi mật khẩu\"]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther").sendKeys("1111");
        iosDriver.findElementByXPath("//XCUIElementTypeAlert[@name=\"Đổi mật khẩu\"]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther").sendKeys("1111");
        iosDriver.findElementByXPath("//XCUIElementTypeAlert[@name=\"Đổi mật khẩu\"]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther").sendKeys("1111");

        iosDriver.switchTo().alert().accept();
    }
}
//XCUIElementTypeAlert[@name="Đổi mật khẩu"]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther
//XCUIElementTypeAlert[@name="Đổi mật khẩu"]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther
//XCUIElementTypeAlert[@name="Đổi mật khẩu"]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeOther