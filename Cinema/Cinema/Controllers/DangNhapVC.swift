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

    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var dangNhapBtnOulet: UIButton!
    @IBOutlet weak var dangKyBtnOulet: UIButton!
    
    //var user = LoginUser()
    static var userDefault = UserDefaults.standard

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
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
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

  @IBAction func hideKeyboardBtn(_ sender: UIButton) {
    view.endEditing(true)
  }
  @IBAction func dangNhapBtn(_ sender: UIButton) {
        if mailTF.text == "" && passTF.text == "" {
            view.makeToast("Bạn phải nhập email và mật khẩu")
        } else if passTF.text == ""{
            view.makeToast("Bạn phải nhập mật khẩu")
        } else if mailTF.text == "" {
            view.makeToast("Bạn phải nhập email")
        } else {

        let info : [String: String] = ["email" : mailTF.text!, "password" : passTF.text!]
        let jsonURLString = baseURL + "/api/auth/signin"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
                guard let getUser = try? JSONDecoder().decode(LoginToken.self, from: response.data!) else {
                    print("error decode")
                    return
                    
                }
                if getUser.status == 200 {
                
                DangNhapVC.userDefault.set(getUser.token, forKey: "token")
                DangNhapVC.userDefault.set(getUser.loginUser.id, forKey: "userID")
                DangNhapVC.userDefault.set(getUser.loginUser.name, forKey: "userName")
                DangNhapVC.userDefault.set(getUser.loginUser.email, forKey: "userEmail")
                //print(self.userDefault.string(forKey: "userName")!)
                self.view.makeToast("Đăng nhập thành công.")
                self.performSegue(withIdentifier: "goDSPhim", sender: self)
                
                
                
                break
                } else {
                     self.view.makeToast("Đăng nhập không thành công.")
                }
            case .failure(let error):
                
                print(error)
            }
        }
    }
        
    }
    @IBAction func dangKyBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goDangKy", sender: self)
    }
    
    @IBAction func datLaiMatKhauBtn(_ sender: Any) {
        var email = UITextField()
        let alert = UIAlertController(title: "Đặt lại mật khẩu", message: nil, preferredStyle: .alert)
        // actions
        let yesBtn = UIAlertAction(title: "Gửi", style: .default) { (btn) in
            self.view.makeToast("Đã gửi")
            
            
            
        }
        let noBtn = UIAlertAction(title: "Hủy", style: .destructive) { (btn) in
            print("Không")
        }
        
        alert.addTextField { (tf) in
            tf.placeholder = "Địa chỉ email của bạn"
            email = tf
        }
        
        alert.addAction(yesBtn)
        alert.addAction(noBtn)
        
        
        present(alert, animated: true, completion: nil)
    }
    
}

