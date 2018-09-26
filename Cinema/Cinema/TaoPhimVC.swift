//
//  TaoPhimVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/26/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit

class TaoPhimVC: UIViewController {

    @IBOutlet weak var chonAnhOutlet: UIButton!
    @IBOutlet weak var taoPhimOutlet: UIButton!
    @IBOutlet weak var tenPhimTF: UITextField!
    @IBOutlet weak var theLoaiTF: UITextField!
    @IBOutlet weak var ngayPhatHanhTF: UITextField!
    @IBOutlet weak var moTaTF: UITextField!
    
    enum listTheLoai : String {
        case hanhDong = "Hành động"
        case tamLy = "Tâm lý"
        case kinhDi = "Kinh dị"
        case khoaHocVienTuong = "Khoa học viễn tưởng"
        case hai = "Hài"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chonAnhOutlet.layer.borderWidth = 5
        chonAnhOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        chonAnhOutlet.layer.cornerRadius = 5
        chonAnhOutlet.layer.shadowRadius = 5
        chonAnhOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        chonAnhOutlet.layer.masksToBounds = false
        chonAnhOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        chonAnhOutlet.layer.shadowOpacity = 1.0
        
        taoPhimOutlet.layer.borderWidth = 5
        taoPhimOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        taoPhimOutlet.layer.cornerRadius = 5
        taoPhimOutlet.layer.shadowRadius = 5
        taoPhimOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        taoPhimOutlet.layer.masksToBounds = false
        taoPhimOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        taoPhimOutlet.layer.shadowOpacity = 1.0
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
