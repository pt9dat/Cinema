//
//  ChiTietPhimVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/28/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit

class ChiTietPhimVC: UIViewController {
    
    var tenPhim : String?
    var theLoai : String?
    var ngayPhatHanh : String?
    var ngayTao : String?
    var moTa : String?
    var poster = UIImage()
    var userID : String?

    @IBOutlet weak var tenPhimTF: UILabel!
    @IBOutlet weak var theLoaiTF: UILabel!
    @IBOutlet weak var ngayPhatHanhTF: UILabel!
    @IBOutlet weak var ngayTaoTF: UILabel!
    @IBOutlet weak var posterImgV: UIImageView!
    @IBOutlet weak var moTaTV: UITextView!
    @IBOutlet weak var editOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editOutlet.frame = CGRect(x: 300, y: 25, width: 60, height: 60)
        editOutlet.setTitle("Edit", for: .normal)
        editOutlet.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editOutlet.clipsToBounds = true
        editOutlet.layer.cornerRadius = 30
        editOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editOutlet.layer.borderWidth = 3.0
        editOutlet.layer.shadowRadius = 5
        editOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editOutlet.layer.masksToBounds = false
        editOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        editOutlet.layer.shadowOpacity = 1.0

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tenPhimTF.text = tenPhim
        theLoaiTF.text = theLoai
        ngayPhatHanhTF.text = ngayPhatHanh
        ngayTaoTF.text = ngayTao
        if moTa == nil || moTa == "" {
            moTaTV.isHidden = true
        } else {
            moTaTV.isHidden = false
            moTaTV.text = moTa
        }
        
        
        if DangNhapVC.userDefault.string(forKey: "userID") == userID {
            editOutlet.isHidden = false
        } else {
            editOutlet.isHidden = true
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEdit" {
            let controller = segue.destination as! TaoPhimVC

            controller.tenPhim = tenPhimTF.text
            controller.theLoai = theLoaiTF.text
            controller.ngayPhatHanh = ngayPhatHanhTF.text
            controller.moTa = moTaTV.text
            //controller.userID = phim.creatorId
            
            
        }
    }

}
