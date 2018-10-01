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
    var posterUrl : String?
    var userID : String?

    @IBOutlet weak var tenPhimTF: UILabel!
    @IBOutlet weak var theLoaiTF: UILabel!
    @IBOutlet weak var ngayPhatHanhTF: UILabel!
    @IBOutlet weak var ngayTaoTF: UILabel!
    @IBOutlet weak var posterImgV: UIImageView!
    @IBOutlet weak var moTaTV: UITextView!
    @IBOutlet weak var editOutlet: UIButton!
    @IBOutlet weak var xoaPhimOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editOutlet.frame = CGRect(x: 310, y: 600, width: 45, height: 45)
        editOutlet.setTitle("Sửa", for: .normal)
        editOutlet.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editOutlet.clipsToBounds = true
        editOutlet.layer.cornerRadius = 5
        editOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editOutlet.layer.borderWidth = 3.0
        editOutlet.layer.shadowRadius = 5
        editOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        editOutlet.layer.masksToBounds = false
        editOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        editOutlet.layer.shadowOpacity = 1.0
        
        xoaPhimOutlet.frame = CGRect(x: 250, y: 600, width: 45, height: 45)
        xoaPhimOutlet.setTitle("Xóa", for: .normal)
        xoaPhimOutlet.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        xoaPhimOutlet.clipsToBounds = true
        xoaPhimOutlet.layer.cornerRadius = 5
        xoaPhimOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        xoaPhimOutlet.layer.borderWidth = 3.0
        xoaPhimOutlet.layer.shadowRadius = 5
        xoaPhimOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        xoaPhimOutlet.layer.masksToBounds = false
        xoaPhimOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        xoaPhimOutlet.layer.shadowOpacity = 1.0

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tenPhimTF.text = tenPhim
        theLoaiTF.text = theLoai
        ngayPhatHanhTF.text = ngayPhatHanh
        ngayTaoTF.text = ngayTao
        DSPhimTBVC.downloadImage(posterUrl: posterUrl!, imgView: posterImgV)
        
        if moTa == nil || moTa == "" {
            moTaTV.isHidden = true
        } else {
            moTaTV.isHidden = false
            moTaTV.text = moTa
        }
        
        
        if DangNhapVC.userDefault.string(forKey: "userID") == userID {
            editOutlet.isHidden = false
            xoaPhimOutlet.isHidden = false
        } else {
            editOutlet.isHidden = true
            xoaPhimOutlet.isHidden = true
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goEdit", sender: self)
    }
    
    @IBAction func xoaBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Xác nhận", message: "Bạn có chắc chắn muốn xóa phim này không?", preferredStyle: .alert)
        // actions
        let yesBtn = UIAlertAction(title: "Có", style: .default) { (btn) in
            
            
            
        }
        let noBtn = UIAlertAction(title: "Không", style: .destructive) { (btn) in
            print("Không")
        }
        alert.addAction(noBtn)
        alert.addAction(yesBtn)
        
        
        
        present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEdit" {
            let controller = segue.destination as! TaoPhimVC

            controller.tenPhim = tenPhimTF.text
            controller.theLoai = theLoaiTF.text
            controller.ngayPhatHanh = ngayPhatHanhTF.text
            controller.moTa = moTaTV.text
            controller.posterURL = posterUrl
            controller.segueName = segue.identifier
            //controller.userID = phim.creatorId
            
            
        }
    }

}
