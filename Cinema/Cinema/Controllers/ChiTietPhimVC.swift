//
//  ChiTietPhimVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/28/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire

class ChiTietPhimVC: UIViewController {
  // MARK: - Class's Property
  var tenPhim : String?
  var theLoai : String?
  var ngayPhatHanh : String?
  var ngayTao : String?
  var moTa : String?
  var posterUrl : String?
  var userID : String?
  var phimID : String?
  var nguoiTao : String?
  var token : String?
  lazy var headers: HTTPHeaders = [
    "x-access-token": token!
  ]
  
  @IBOutlet weak var tenPhimTF: UILabel!
  @IBOutlet weak var theLoaiTF: UILabel!
  @IBOutlet weak var ngayPhatHanhTF: UILabel!
  @IBOutlet weak var ngayTaoTF: UILabel!
  @IBOutlet weak var posterImgV: UIImageView!
  @IBOutlet weak var moTaTV: UITextView!
  @IBOutlet weak var editOutlet: UIButton!
  @IBOutlet weak var xoaPhimOutlet: UIButton!
  @IBOutlet weak var nguoiTaoTF: UILabel!
  
  // MARK: - UIViewController's methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    tenPhimTF.text = tenPhim
    theLoaiTF.text = theLoai
    ngayPhatHanhTF.text = ngayPhatHanh
    ngayTaoTF.text = ngayTao
    nguoiTaoTF.text = nguoiTao
    downloadImage(posterUrl: posterUrl!, imgView: posterImgV)
    
    if moTa == nil || moTa == "" {
      moTaTV.isHidden = true
    } else {
      moTaTV.isHidden = false
      moTaTV.text = moTa
    }

    if userDefault.string(forKey: "userID") == userID {
      editOutlet.isHidden = false
      xoaPhimOutlet.isHidden = false
    } else {
      editOutlet.isHidden = true
      xoaPhimOutlet.isHidden = true
    }
    token = userDefault.string(forKey: "token")
  }
}

//MARK: - Button's action
extension ChiTietPhimVC {
  
  // Back
  @IBAction func backBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    self.dismiss(animated: true, completion: nil)
  }
  
  // Sua phim
  @IBAction func editBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "goEdit", sender: self)
  }
  
  // Xoa phim
  @IBAction func xoaBtn(_ sender: UIButton) {
    let alert = UIAlertController(title: "Xác nhận", message: "Bạn có chắc chắn muốn xóa phim này không?", preferredStyle: .alert)
    // actions
    let yesBtn = UIAlertAction(title: "Có", style: .default) { (btn) in
      let info : [String: String] = ["_id" : self.phimID!]
      let jsonURLString = baseURL + "/api/cinema/delete"
      guard let url = URL(string: jsonURLString) else {return}
      Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response) in
        switch response.result {
        case .success:
          print(response)
          var status = response.response?.statusCode
          if status == 200 {
            self.view.makeToast("Đã xóa phim.")
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
          } else {
            self.view.makeToast("Lỗi")
            break
          }
        break
        case .failure(let error):
          print(error)
        }
      }
    }
    let noBtn = UIAlertAction(title: "Không", style: .destructive) { (btn) in
      print("Không")
    }
    alert.addAction(noBtn)
    alert.addAction(yesBtn)
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - Segue's methods
extension ChiTietPhimVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goEdit" {
      let controller = segue.destination as! TaoPhimVC
      controller.tenPhim = tenPhimTF.text
      controller.theLoai = theLoaiTF.text
      controller.ngayPhatHanh = ngayPhatHanhTF.text
      controller.moTa = moTaTV.text
      controller.posterURL = posterUrl
      controller.segueName = segue.identifier
      controller.phimID = phimID
      //controller.userID = phim.creatorId
    }
  }
  
}
