//
//  DangKyVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire

class DangKyVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confPassTF: UITextField!
    @IBOutlet weak var dangKyBtnOulet: UIButton!
    @IBOutlet weak var dangNhapBtnOulet: UIButton!
    
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
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    @IBAction func dangKyBtn(_ sender: UIButton) {
        if mailTF.text == "" && passTF.text == "" && passTF.text == "" {
            view.makeToast("Bạn phải nhập tên, email và mật khẩu")
        } else if passTF.text == ""{
            view.makeToast("Bạn phải nhập mật khẩu")
        } else if mailTF.text == "" {
            view.makeToast("Bạn phải nhập email")
        } else
        if passTF.text != confPassTF.text {
            view.makeToast("Mật khẩu xác nhận không khớp")
        } else {
        let info : [String : String] = ["email" : mailTF.text!, "name" : userNameTF.text!, "password" : passTF.text!]
        let jsonURLString = baseURL + "/api/auth/signup"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
                guard let getUser = try? JSONDecoder().decode(RegisterUser.self, from: response.data!) else {
                    print("error decode")
                    return
                    
                }
                
                //DangNhapVC.userDefault.set(getUser.token, forKey: "token")
                DangNhapVC.userDefault.set(getUser.user.id, forKey: "userID")
                DangNhapVC.userDefault.set(getUser.user.name, forKey: "userName")
                DangNhapVC.userDefault.set(getUser.user.email, forKey: "userEmail")
                self.performSegue(withIdentifier: "goDSPhim", sender: self)
                break
            case .failure(let error):
                
                print(error)
            }
        }
       
        }
        //performSegue(withIdentifier: "goDangNhap", sender: self)

        
    }
    
    @IBAction func dangNhapBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goDangNhap", sender: self)
    }

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
