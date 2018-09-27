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
        if passTF.text == confPassTF.text {
        let info : [String: String] = ["email" : mailTF.text!, "name" : userNameTF.text!, "password" : passTF.text!]
        let jsonURLString = baseURL + "/api/auth/signup"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
                self.performSegue(withIdentifier: "goDangNhap", sender: self)
                break
            case .failure(let error):
                
                print(error)
            }
        }
       
        } else {
            print("error")
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
