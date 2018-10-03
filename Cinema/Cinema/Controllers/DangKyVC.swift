//
//  DangKyVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire
import Toast

class DangKyVC: UIViewController {
  // MARK: - Class's Property
  @IBOutlet weak var userNameTF: UITextField!
  @IBOutlet weak var mailTF: UITextField!
  @IBOutlet weak var passTF: UITextField!
  @IBOutlet weak var confPassTF: UITextField!
  @IBOutlet weak var dangKyBtnOulet: UIButton!
  @IBOutlet weak var dangNhapBtnOulet: UIButton!
  
  // MARK: - UIViewController's methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dangKyBtnOulet.layer.borderWidth = 5
    dangKyBtnOulet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    dangKyBtnOulet.layer.cornerRadius = 5
    dangKyBtnOulet.layer.shadowRadius = 5
    dangKyBtnOulet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    dangKyBtnOulet.layer.masksToBounds = false
    dangKyBtnOulet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    dangKyBtnOulet.layer.shadowOpacity = 1.0
    
    dangNhapBtnOulet.layer.borderWidth = 5
    dangNhapBtnOulet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    dangNhapBtnOulet.layer.cornerRadius = 5
    dangNhapBtnOulet.layer.shadowRadius = 5
    dangNhapBtnOulet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    dangNhapBtnOulet.layer.masksToBounds = false
    dangNhapBtnOulet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    dangNhapBtnOulet.layer.shadowOpacity = 1.0
  }
  override func viewWillAppear(_ animated: Bool) {
    UIApplication.shared.statusBarStyle = .lightContent
  }
}

// MARK: - Button's action
extension DangKyVC {
  // Hide keyboard
  @IBAction func hideKeyboard(_ sender: UIButton) {
    view.endEditing(true)
  }
  
  // Dang ky
  @IBAction func dangKyBtn(_ sender: UIButton) {
    if userNameTF.text == nil || userNameTF.text == "" {
      view.makeToast("Bạn phải nhập tên user")
    } else if mailTF.text == nil || mailTF.text == "" {
      view.makeToast("Bạn phải nhập email")
    } else if passTF.text == nil || passTF.text == "" {
      view.makeToast("Bạn phải nhập mật khẩu")
    } else if confPassTF.text == nil || confPassTF.text == "" {
      view.makeToast("Bạn phải xác nhận mật khẩu")
    } else if passTF.text != confPassTF.text {
      view.makeToast("Mật khẩu xác nhận không khớp")
    } else if isValidEmail(testStr: mailTF.text!) == false {
      view.makeToast("Định dạng email không đúng")
    } else {
      let info : [String : String] = ["email" : mailTF.text!, "name" : userNameTF.text!, "password" : passTF.text!]
      let jsonURLString = baseURL + "/api/auth/signup"
      guard let url = URL(string: jsonURLString) else {return}
      Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default).responseJSON { (response) in
        switch response.result {
        case .success:
          print(response)
          let status = response.response?.statusCode
          if status == 400 {
            self.view.makeToast("Địa chỉ email không hợp lệ")
          } else if response.response?.statusCode == 200 {
            guard let getUser = try? JSONDecoder().decode(LoginToken.self, from: response.data!) else {
              print("error decode")
              return
            }
            print(response.response?.statusCode)
            self.view.makeToast("Đăng ký thành công")
            userDefault.set(getUser.token, forKey: "token")
            userDefault.set(getUser.loginUser.id, forKey: "userID")
            userDefault.set(getUser.loginUser.name, forKey: "userName")
            userDefault.set(getUser.loginUser.email, forKey: "userEmail")
            self.performSegue(withIdentifier: "goDSPhim", sender: self)
            break
          } else {
            self.view.makeToast("Đăng ký không thành công")
          }
        case .failure(let error):
          print(error)
        }
      }
    }
    //performSegue(withIdentifier: "goDangNhap", sender: self)
  }
  
  // Dang nhap
  @IBAction func dangNhapBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "goDangNhap", sender: self)
  }
}

