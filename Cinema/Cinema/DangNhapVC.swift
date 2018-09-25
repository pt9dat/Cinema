//
//  ViewController.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit

class DangNhapVC: UIViewController {

    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func dangNhapBtn(_ sender: UIButton) {
       
        performSegue(withIdentifier: "goDSPhim", sender: self)
    }
    @IBAction func dangKyBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goDangKy", sender: self)
    }
}

