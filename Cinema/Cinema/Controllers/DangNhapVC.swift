//
//  ViewController.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire
import Toast

class DangNhapVC: UIViewController {
  // MARK: - Class's Property
  @IBOutlet weak var mailTF: UITextField!
  @IBOutlet weak var passTF: UITextField!
  @IBOutlet weak var dangNhapBtnOulet: UIButton!
  @IBOutlet weak var dangKyBtnOulet: UIButton!
  
  // MARK: - UIViewController's methods
  fileprivate func configUI() {
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UIApplication.shared.statusBarStyle = .lightContent
  }
}

// MARK: - Button's action
extension DangNhapVC {
  // Hide keyboard
  @IBAction func hideKeyboardBtn(_ sender: UIButton) {
    view.endEditing(true)
    
  }
  // Back
  @IBAction func backBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "goDSPhim", sender: self)
  }
  
  // Dang nhap
  @IBAction func dangNhapBtn(_ sender: UIButton) {
    if mailTF.text == nil || mailTF.text == "" {
      view.makeToast("Bạn phải nhập email")
    } else if passTF.text == nil || passTF.text == "" {
      view.makeToast("Bạn phải nhập mật khẩu")
    } else if isValidEmail(testStr: mailTF.text!) == false {
      view.makeToast("Email không đúng")
    } else {
      let info : [String: String] = ["email" : mailTF.text!, "password" : passTF.text!]
      guard let url = URL(string: baseURL + "/api/auth/signin") else { return }
      Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        switch response.result {
        case .success:
          let status = response.response?.statusCode
          print(response)
          if status == 404 {
            self.view.makeToast("Sai email hoặc mật khẩu")
          } else if status == 200 {
            guard let getUser = try? JSONDecoder().decode(LoginToken.self, from: response.data!) else {
              print("error decode")
              return
            }
            if getUser.status == 200 {
              self.view.makeToast("Đăng nhập thành công.")
              userDefault.set(getUser.token, forKey: "token")
              userDefault.set(getUser.loginUser.id, forKey: "userID")
              userDefault.set(getUser.loginUser.name, forKey: "userName")
              userDefault.set(getUser.loginUser.email, forKey: "userEmail")
              self.performSegue(withIdentifier: "goDSPhim", sender: self)
              break
            } else {
              self.view.makeToast("Đăng nhập không thành công.")
            }
          }
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  
  // Dang ky
  @IBAction func dangKyBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "goDangKy", sender: self)
  }
  
  // Dat lai mat khau
  @IBAction func datLaiMatKhauBtn(_ sender: Any) {
    var email = UITextField()
    let alert = UIAlertController(title: "Đặt lại mật khẩu", message: nil, preferredStyle: .alert)
    // actions
    let yesBtn = UIAlertAction(title: "Gửi", style: .default) { (btn) in
      if email.text == nil || email.text == "" {
        self.view.makeToast("Bạn phải nhập email")
      } else if isValidEmail(testStr: email.text!) == false {
        self.view.makeToast("Email không đúng")
      } else {
        let info : [String: String] = ["email" : email.text!]
        guard let url = URL(string: baseURL + "/api/auth/reset-password") else { return }
        Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
          switch response.result {
          case .success:
            let status = response.response?.statusCode
            print(response)
            print(status)
            if status == 200 {
              self.view.makeToast("Gửi yêu cầu thành công, vui lòng kiểm tra email")
            } else {
              self.view.makeToast("Không tìm thấy tài khoản, vui lòng kiểm tra lại địa chỉ email")
            }
            break
          case .failure(let error):
            print(error)
          }
        }
      }
    }
    let noBtn = UIAlertAction(title: "Hủy", style: .destructive) { (btn) in
      print("Không")
    }
    alert.addTextField { (tf) in
      tf.placeholder = "Địa chỉ email của bạn"
      email = tf
    }
    alert.addAction(noBtn)
    alert.addAction(yesBtn)
    present(alert, animated: true, completion: nil)
  }
}
