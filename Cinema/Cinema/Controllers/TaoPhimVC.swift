//
//  TaoPhimVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/26/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import HSDatePickerViewController
import Alamofire
import EZLoadingActivity

class TaoPhimVC: UIViewController {
  // MARK: - Class's Property
  @IBOutlet weak var chonAnhOutlet: UIButton!
  @IBOutlet weak var taoPhimOutlet: UIButton!
  @IBOutlet weak var tenPhimTF: UITextField!
  @IBOutlet weak var theLoaiTF: UITextField!
  @IBOutlet weak var ngayPhatHanhTF: UITextField!
  @IBOutlet weak var theLoaiPickerView: UIPickerView!
  @IBOutlet weak var posterImg: UIImageView!
  @IBOutlet weak var moTaTV: UITextView!
  @IBOutlet var heightConstraint: NSLayoutConstraint!
  
  let datePK = HSDatePickerViewController()
  let imgPicker = UIImagePickerController()
  var img = UIImage()
  let listTheLoai = ["Hành động", "Tâm lý", "Kinh dị", "Khoa học viễn tưởng", "Hài"]
  lazy var headers: HTTPHeaders = [
    "x-access-token": token!
  ]
  
  var token : String?
  var tenPhim : String?
  var theLoai : String?
  var ngayPhatHanh : String?
  var moTa : String?
  var poster = UIImage()
  var userID : String?
  var segueName : String?
  var posterURL : String?
  var phimID : String?
  
  // MARK: - UIViewController's methods
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
    
    datePK.delegate = self
    theLoaiPickerView.delegate = self
    theLoaiTF.delegate = self
    imgPicker.delegate = self
    
    if let segueID = segueName {
      theLoaiTF.text = theLoai
      tenPhimTF.text = tenPhim
      ngayPhatHanhTF.text = ngayPhatHanh
      moTaTV.text = moTa
      downloadImage(posterUrl: posterURL!, imgView: posterImg)
      taoPhimOutlet.setTitle("Sửa phim", for: .normal)
      print("")
    } else {
      taoPhimOutlet.setTitle("Tạo phim", for: .normal)
      theLoaiTF.text = listTheLoai[0]
      let date = Date()
      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yyyy"
      let result = formatter.string(from: date)
      ngayPhatHanhTF.text = result
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    token = userDefault.string(forKey: "token")
  }
  
  override func viewDidAppear(_ animated: Bool) {
//    if let segueID = segueName {
//      posterImg.image = img
//    }
  }
  
  
}

// MARK: - Button's action
extension TaoPhimVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  // Hide Keyboard
  @IBAction func hideKBBtn(_ sender: UIButton) {
    view.endEditing(true)
  }
  
  // Ngay phat hanh
  @IBAction func ngayPhatHanhAction(_ sender: UITextField) {
    present(datePK, animated: true, completion: nil)
  }
  
  //Tao phim
  @IBAction func taoPhimBtn(_ sender: UIButton) {
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="dd/MM/yyyy"
    let date = dfmatter.date(from: ngayPhatHanhTF.text!)
    let dateStamp:TimeInterval = date!.timeIntervalSince1970
    let dateSt:Int = Int(dateStamp)
    let randomNum:UInt32 = arc4random_uniform(999999)
    let number:Int = Int(randomNum)
    var fileName = "dat-\(number).jpg"
    let creatorID = userDefault.string(forKey: "userID")
    var info : [String: Any]?
    var url : String?
    print(creatorID!)
    if let segue = segueName {
      info = ["name" : tenPhimTF.text!, "genre" : theLoaiTF.text!, "releaseDate" : dateSt, "content" : moTaTV.text!, "creatorId" : creatorID!, "id": phimID!]
      url = baseURL + "/api/cinema/edit"
    } else {
      info = ["name" : tenPhimTF.text!, "genre" : theLoaiTF.text!, "releaseDate" : dateSt, "content" : moTaTV.text!, "creatorId" : creatorID!]
      url = baseURL + "/api/cinema/"
      //headers = nil
    }
    
    Alamofire.upload(multipartFormData: { (multipartFormData) in
      for (key, values) in info! {
        multipartFormData.append("\(values)".data(using: String.Encoding.utf8)!, withName: key as String)
      }
      if let data = UIImageJPEGRepresentation(self.img, 1.0) {
        multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "image/jpeq")
      }
    }, to: url!, method: .post, headers: headers)  { encodingResult in
      switch encodingResult {
      case .success(let upload, _, _):
        upload.responseJSON { response in
          debugPrint(response)
        }
        print(self.segueName)
        if self.segueName == "goEdit" {
          EZLoadingActivity.show("Đang sửa phim...", disableUI: false)
        } else {
          EZLoadingActivity.show("Đang tạo phim...", disableUI: false)
        }
        
        upload.uploadProgress{
          print("-----> ", $0.fractionCompleted)
          
          if $0.fractionCompleted == 1 {
            EZLoadingActivity.hide(true, animated: true)

            self.performSegue(withIdentifier: "goDSPhim", sender: self)
            
          }
        }
      case .failure(let encodingError):
        print(encodingError)
      }
    }
  }
  
  // Back
  @IBAction func backBtn(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
    dismiss(animated: true, completion: nil)
  }
  
  // Chon anh
  @IBAction func chonAnhBtn(_ sender: Any) {
    imgPicker.allowsEditing = false
    imgPicker.sourceType = .photoLibrary
    
    present(imgPicker, animated: true, completion: nil)
  }
}

// MARK: - UIPickerViewDelegate's methods
extension TaoPhimVC: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    self.view.endEditing(true)
    return listTheLoai[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.theLoaiTF.text = self.listTheLoai[row]
    self.theLoaiPickerView.isHidden = true
  }
  
}

// MARK: - UIPickerViewDataSource's methods
extension TaoPhimVC: UIPickerViewDataSource {
  public func numberOfComponents(in pickerView: UIPickerView) -> Int{
    return 1
  }
  
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{    
    return listTheLoai.count
  }
}

// MARK: - UITextFieldDelegate's methods
extension TaoPhimVC: UITextFieldDelegate {
  
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == self.theLoaiTF {
      self.theLoaiPickerView.isHidden = false
      textField.endEditing(true)
    }
    if textField == self.moTaTV {
      UIView.animate(withDuration: 0.5) {
        self.heightConstraint.constant = 508
        self.view.layoutIfNeeded()
        
      }
    }
    
    }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == self.moTaTV {
      UIView.animate(withDuration: 0.5) {
        self.heightConstraint.constant = 50
        self.view.layoutIfNeeded()
      }
    }
  }
  }



// MARK: - UIIMagePickerController's methods
extension TaoPhimVC{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      posterImg.contentMode = .scaleAspectFit
      posterImg.image = pickedImage
      img = pickedImage
    }
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - HSDatePickerViewControllerDelegate's methods
extension TaoPhimVC: HSDatePickerViewControllerDelegate {
  func hsDatePickerPickedDate(_ date: Date!) {
    print("Date picked \(date)")
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd/MM/yyyy"
    ngayPhatHanhTF.text = dateFormater.string(from: date)
    
  }
}

extension TaoPhimVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goDSPhim" {
      let controller = segue.destination as! DSPhimTBVC
      controller.tenPhim = tenPhimTF.text
      controller.theLoai = theLoaiTF.text
      controller.ngayPhatHanh = ngayPhatHanhTF.text
      controller.moTa = moTaTV.text
      controller.poster = img
      controller.segueID = "goDSPhim"
    }
  }
}
