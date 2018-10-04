package base;

import io.appium.java_client.MobileElement;
import io.appium.java_client.ios.IOSDriver;
import io.appium.java_client.pagefactory.AppiumFieldDecorator;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.concurrent.TimeUnit;

public class EditMovie {
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

    @FindBy(id = "sua_phim_btn")
    MobileElement suaPhimBtn;

    private IOSDriver iosDriver;
    private WebDriverWait wait;

    String email = "dat2222@mail.com";
    String pass = "1111";
    String title = "dat phim 16";


    public EditMovie(IOSDriver iosDriver) {
        this.iosDriver = iosDriver;
        PageFactory.initElements(new AppiumFieldDecorator(iosDriver, 30, TimeUnit.SECONDS), this);
        this.wait = new WebDriverWait(iosDriver, 30);

    }

    public void testEditMovie() {
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

        suaPhimBtn.click();

        chonAnhBtn.click();
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        iosDriver.findElementByAccessibilityId("Camera Roll").click();
        iosDriver.findElementByAccessibilityId("Photo, Landscape, August 09, 2012, 1:52 AM").click();
        tenPhimTF.clear();
        tenPhimTF.sendKeys(title);
        hideKbBtn.click();
        theLoaiTF.click();
        theLoaiPicker.findElementsByXPath("//XCUIElementTypePicker[@name=\"the_loai_picker\"]/XCUIElementTypePickerWheel/XCUIElementTypeOther[5]");

        //ngayPhatHanhTF.click();
//        try {
//            Thread.sleep(3000);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//        ngay phat hanh picker Set date
//        ngayPhatHanhTF.sendKeys("04/10/2018");
        //iosDriver.findElementByXPath("//XCUIElementTypeApplication[@name=\"Cinema\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther[3]/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypePicker/XCUIElementTypePickerWheel[1]");
        //iosDriver.findElementByXPath("//XCUIElementTypeApplication[@name=\"Cinema\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther[3]/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[3]/XCUIElementTypeOther/XCUIElementTypePicker/XCUIElementTypePickerWheel[1]/XCUIElementTypeOther[95]").click();
//        iosDriver.findElementByXPath("Set date");
        hideKbBtn.click();
        moTaTV.clear();
        moTaTV.sendKeys("mo ta phim dat 16");
        hideKbBtn.click();
        taoPhimBtn.click();
        try {
            Thread.sleep(40000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //phimCell1.findElementsByXPath("//XCUIElementTypeApplication[@name=\"Cinema\"]/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeTable/XCUIElementTypeCell[1]")
        if (cellTenPhimLbl.getText().equals(title) && cellNguoiTaoLbl.getText().equals("dat2")) {
            System.out.println("co phim vua sua: " + cellTenPhimLbl.getText());

        } else {
            System.out.println("chua co");
        }
    }
}
