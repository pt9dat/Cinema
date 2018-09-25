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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dangKyBtn(_ sender: UIButton) {
        let info : [String: String] = ["email" : mailTF.text!, "username" : userNameTF.text!, "password" : passTF.text!  ]
        let jsonURLString = "https://cinema-hatin.herokuapp.com/api/auth/signup"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url, method: .post, parameters: info)
        
        performSegue(withIdentifier: "goDangNhap", sender: self)
        
    }
    
    @IBAction func dangNhapBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goDangNhap", sender: self)
    }
}
