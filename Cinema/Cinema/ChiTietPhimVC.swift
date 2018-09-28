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

    @IBOutlet weak var tenPhimTF: UILabel!
    @IBOutlet weak var theLoaiTF: UILabel!
    @IBOutlet weak var ngayPhatHanhTF: UILabel!
    @IBOutlet weak var ngayTaoTF: UILabel!
    @IBOutlet weak var moTaTF: UILabel!
    @IBOutlet weak var posterImgV: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tenPhimTF.text = tenPhim
        theLoaiTF.text = theLoai
        ngayPhatHanhTF.text = ngayPhatHanh
        ngayTaoTF.text = ngayTao
        moTaTF.text = moTa
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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
