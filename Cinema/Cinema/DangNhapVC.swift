//
//  ViewController.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire

class DangNhapVC: UIViewController {

    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var dangNhapBtnOulet: UIButton!
    @IBOutlet weak var dangKyBtnOulet: UIButton!
    
    let token = UserDefaults()
    
    
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

    @IBAction func dangNhapBtn(_ sender: UIButton) {
        let info : [String: String] = ["email" : mailTF.text!, "password" : passTF.text!]
        let jsonURLString = "https://cinema-hatin.herokuapp.com/api/auth/signin"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response.)
                self.token.set(, forKey: "token")
                self.performSegue(withIdentifier: "goDSPhim", sender: self)
                break
            case .failure(let error):
                
                print(error)
            }
        }
        
    }
    @IBAction func dangKyBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goDangKy", sender: self)
    }
}

