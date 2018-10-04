package base;

import io.appium.java_client.MobileElement;
import io.appium.java_client.ios.IOSDriver;
import io.appium.java_client.pagefactory.AppiumFieldDecorator;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.concurrent.TimeUnit;

public class DeleteMovie {
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

    private IOSDriver iosDriver;
    private WebDriverWait wait;

    String email = "dat2222@mail.com";
    String pass = "1111";
    String title = "dat phim 16";


    public DeleteMovie(IOSDriver iosDriver) {
        this.iosDriver = iosDriver;
        PageFactory.initElements(new AppiumFieldDecorator(iosDriver, 30, TimeUnit.SECONDS), this);
        this.wait = new WebDriverWait(iosDriver, 30);

    }

    public void testDeleteMovie() {
        mhTaoPhimBtn.click();
        iosDriver.switchTo().alert().accept();

        emailTF.sendKeys(email);
        passTF.sendKeys(pass);
        dnHideKbBtn.click();
        loginBtn.click();

        cellTenPhimLbl.click();
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        xoaPhimBtn.click();

        iosDriver.switchTo().alert().accept();
    }
}
