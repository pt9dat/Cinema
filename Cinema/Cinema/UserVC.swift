//
//  UserVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/28/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire
import Toast
import SDWebImage

class UserVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

  
  
  
  
  
  
  @IBOutlet weak var doiMatKhauOutlet: UIButton!
  @IBOutlet weak var dangXuatOutlet: UIButton!
  @IBOutlet weak var avatarOutlet: UIButton!
  @IBOutlet weak var userNameOutlet: UIButton!
  @IBOutlet weak var dsPhimView: UICollectionView!
  @IBOutlet weak var emailLbl: UILabel!
  @IBOutlet weak var userNameLbl: UILabel!
  @IBOutlet weak var scrollViewOutlet: UIScrollView!
  
  var avatar = UIImage()
  var token : String?
  let imgPicker = UIImagePickerController()
  var listPhimUser = [Phim]()
  var listPhim = [Phim]()
  var user = User()
  var avatarUrl : String?
  let refreshControl = UIRefreshControl()
  lazy var headers: HTTPHeaders = [
    "x-access-token": token!
  ]
  
  
  
  
  
  fileprivate func configUI() {
    doiMatKhauOutlet.layer.borderWidth = 5
    doiMatKhauOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    doiMatKhauOutlet.layer.cornerRadius = 5
    doiMatKhauOutlet.layer.shadowRadius = 5
    doiMatKhauOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    doiMatKhauOutlet.layer.masksToBounds = false
    doiMatKhauOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    doiMatKhauOutlet.layer.shadowOpacity = 1.0
    
    dangXuatOutlet.layer.borderWidth = 5
    dangXuatOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    dangXuatOutlet.layer.cornerRadius = 5
    dangXuatOutlet.layer.shadowRadius = 5
    dangXuatOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    dangXuatOutlet.layer.masksToBounds = false
    dangXuatOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    dangXuatOutlet.layer.shadowOpacity = 1.0
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    
    imgPicker.delegate = self
    dsPhimView.delegate = self
    dsPhimView.dataSource = self
    refreshControl.tintColor = .white
    

    
    //scrollViewOutlet.addSubview(refreshControl)  // here it is
    scrollViewOutlet.isScrollEnabled = true
    scrollViewOutlet.alwaysBounceVertical = true
    

    
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    userNameLbl.text = DangNhapVC.userDefault.string(forKey: "userName")
    emailLbl.text = DangNhapVC.userDefault.string(forKey: "userEmail")
    token = DangNhapVC.userDefault.string(forKey: "token")
    
    scrollViewOutlet.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
//    if let url = listPhimUser[0].user.avatar {
//      avatar.
    //}
  }
  
  @objc func updateData() {
    reloadUserInfo()
    reloadListPhim()
    refreshControl.endRefreshing()
  }
  
  func reloadListPhim () {
    let jsonURLString = baseURL + "/api/cinema"
    guard let url = URL(string: jsonURLString) else {return}
    Alamofire.request(url).responseJSON { [weak self](response) in
      guard let `self` = self else { return }
      if response.result.isSuccess {
  
        guard let list = try? JSONDecoder().decode(ListFilm.self, from: response.data!) else {
          print("error load")
          return
          
        }
        
        self.listPhimUser = list.movies.filter({ (phim) -> Bool in
          return phim.creatorId == DangNhapVC.userDefault.string(forKey: "userID")
        })
        
        self.dsPhimView.reloadData()
      } else {
        print("fail")
      }
    }
  }
  
  func reloadUserInfo() {
    
  
    let info : [String : String] = ["token" : DangNhapVC.userDefault.string(forKey: "token")!]
    let jsonURLString = baseURL + "/api/auth/user"
    guard let url = URL(string: jsonURLString) else {return}
    Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default).responseJSON { (response) in
      switch response.result {
      case .success:
        print(response)
          guard let getUser = try? JSONDecoder().decode(User.self, from: response.data!) else {
            print("error decode")
            return

          }


          DangNhapVC.userDefault.set(getUser.username, forKey: "userName")
        self.userNameLbl.text = DangNhapVC.userDefault.string(forKey: "userName")


          break


      case .failure(let error):

        print(error)

    }

    }
    }

  @objc func append(sender: UILongPressGestureRecognizer, actionBtn: UIAlertAction, alert: UIAlertController, oldPass: String, newPass: String) {
    
    if sender.state == .began {
      actionBtn.isEnabled = false
    } else if sender.state == .ended {
      // Do whatever you want with the alert text fields
      print(alert.textFields![0].text)
      actionBtn.isEnabled = true
    }
  }
  
  
  @IBAction func doiMatKhauBtn(_ sender: UIButton) {
    
    var oldPassTF = UITextField()
    var newPassTF = UITextField()
    var confNewPassTF = UITextField()
    let alert = UIAlertController(title: "Đổi mật khẩu", message: "", preferredStyle: .alert)
    let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.append(sender:actionBtn:alert:oldPass:newPass:)))
    gestureRecognizer.minimumPressDuration = 0.0
    alert.view.addGestureRecognizer(gestureRecognizer)
    
    let actionDoi = UIAlertAction(title: "Đổi", style: .default) { (action) in
      if oldPassTF.text == nil || oldPassTF.text == "" {
        self.view.makeToast("Bạn phải nhập mật khẩu hiện tại")
      } else if newPassTF.text == nil || newPassTF.text == "" {
        self.view.makeToast("Bạn phải nhập mật khẩu mới")
      } else if oldPassTF.text == nil || oldPassTF.text == "" {
        self.view.makeToast("Bạn phải xác nhận mật khẩu mới")
      } else if newPassTF.text != confNewPassTF.text {
        self.view.makeToast("Mật khẩu xác nhận không khớp")
      } else {
        let info : [String: String] = ["oldPassword" : oldPassTF.text!, "newPassword" : newPassTF.text!]
        let jsonURLString = baseURL + "/api/user/change-password"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response) in
          switch response.result {
          case .success:
            print(response)
            
            guard let getStatus = try? JSONDecoder().decode(statusAPI.self, from: response.data!) else {
              print("error decode")
              return
              
            }
            let status = getStatus.status
            print(status)
            if status == 200 {
              self.view.makeToast("Đổi mật khẩu thành công.")
            } else {
              self.view.makeToast("Mật khẩu hiện tại không đúng.")

            }
            
            
            
            //self.performSegue(withIdentifier: "goDSPhim", sender: self)
            
            
            
            break
          case .failure(let error):
            
            print(error)
          }
        }
      }
    }
    
    let actionHuy = UIAlertAction(title: "Hủy", style: .destructive)
    alert.addTextField { (tf) in
      tf.placeholder = "Mật khẩu hiện tại"
      tf.isSecureTextEntry = true
      oldPassTF = tf
    }
    
    alert.addTextField { (tf) in
      tf.placeholder = "Mật khẩu mới"
      tf.isSecureTextEntry = true
      newPassTF = tf
    }
    alert.addTextField { (tf) in
      tf.placeholder = "Nhập lại mật khẩu mới"
      tf.isSecureTextEntry = true
      confNewPassTF = tf
    }
    
    alert.addAction(actionHuy)
    alert.addAction(actionDoi)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func dangXuatBtn(_ sender: UIButton) {
    let alert = UIAlertController(title: "Xác nhận", message: "Bạn có muốn đăng xuất?", preferredStyle: .alert)
    // actions
    let yesBtn = UIAlertAction(title: "Có", style: .default) { (btn) in
      DangNhapVC.userDefault.removeObject(forKey: "token")
      DangNhapVC.userDefault.removeObject(forKey: "userID")
      DangNhapVC.userDefault.removeObject(forKey: "userName")
      DangNhapVC.userDefault.removeObject(forKey: "userEmail")
      //print(DangNhapVC.userDefault.string(forKey: "token"))
      
      self.performSegue(withIdentifier: "goDangNhap", sender: self); //self.navigationController?.popViewController(animated: true)
      //self.dismiss(animated: true, completion: nil)
      
      
      
    }
    let noBtn = UIAlertAction(title: "Không", style: .destructive) { (btn) in
      print("Không")
    }
    alert.addAction(noBtn)
    alert.addAction(yesBtn)
    
    
    
    
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func backBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func doiAvatarBtn(_ sender: UIButton) {
    imgPicker.allowsEditing = false
    imgPicker.sourceType = .photoLibrary
    
    present(imgPicker, animated: true, completion: nil)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      avatarOutlet.imageView?.contentMode = .scaleAspectFit
      avatarOutlet.setImage(pickedImage, for: .normal)
      avatar = pickedImage
      let randomNum:UInt32 = arc4random_uniform(999999)
      let number:Int = Int(randomNum)
      let fileName = "dat-\(number).jpg"
      let url = baseURL + "/api/user/change-avatar"
      
      
      Alamofire.upload(multipartFormData: { (multipartFormData) in
        
        if let data = UIImageJPEGRepresentation(pickedImage, 1.0) {
          
          multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "image/jpeq")
        }
        
      }, to: url, method: .post, headers: headers)  { encodingResult in
        switch encodingResult {
        case .success(let upload, _, _):
          
          upload.responseJSON { response in
            debugPrint(response)
            
          }
          
          upload.uploadProgress{
            
            print("-----> ", $0.fractionCompleted)
            
          }
          print("done")
          
          
        case .failure(let encodingError):
          print(encodingError)
        }
      }
      
      
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  //  private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
  //        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
  //            avatarOutlet.imageView?.contentMode = .scaleAspectFit
  //            avatarOutlet.setImage(pickedImage, for: .normal)
  //            avatar = pickedImage
  //          let number = Int.random(in: 100000 ... 999999)
  //          var fileName = "dat-\(number).jpg"
  //          let url = baseURL + "/api/user/change-avatar"
  //
  //
  //          Alamofire.upload(multipartFormData: { (multipartFormData) in
  //
  //            if let data = UIImage.jpegData(pickedImage)(compressionQuality: 1) {
  //
  //              multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: "image/jpeq")
  //            }
  //
  //          }, to: url, method: .post, headers: headers)  { encodingResult in
  //            switch encodingResult {
  //            case .success(let upload, _, _):
  //
  //              upload.responseJSON { response in
  //                debugPrint(response)
  //
  //              }
  //
  //              upload.uploadProgress{
  //
  //                print("-----> ", $0.fractionCompleted)
  //
  //              }
  //              print("done")
  //
  //
  //            case .failure(let encodingError):
  //              print(encodingError)
  //            }
  //          }
  //
  //
  //        }
  //
  //        dismiss(animated: true, completion: nil)
  //    }
  
  @IBAction func userNameBtn(_ sender: Any) {
    var newNameTF = UITextField()
    let alert = UIAlertController(title: "Đổi tên user", message: "", preferredStyle: .alert)
    let actionYes = UIAlertAction(title: "Đổi", style: .default) { (action) in
      let info : [String: String] = ["name" : newNameTF.text!]
      let jsonURLString = baseURL + "/api/user/edit"
      guard let url = URL(string: jsonURLString) else {return}
      Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default, headers: self.headers).responseJSON { (response) in
        switch response.result {
        case .success:
          print(response)
          guard let getStatus = try? JSONDecoder().decode(statusAPI.self, from: response.data!) else {
            print("error decode")
            return
            
          }
          if getStatus.status == 200 {
            self.view.makeToast("Đổi tên thành công.")
            DangNhapVC.userDefault.removeObject(forKey: "userName")
            DangNhapVC.userDefault.set(newNameTF.text, forKey: "userName")
            self.userNameLbl.text = newNameTF.text
          } else {
            self.view.makeToast("Lỗi.")
            break
          }
          
          
          
          //self.performSegue(withIdentifier: "goDSPhim", sender: self)
          
          
          
          break
        case .failure(let error):
          
          print(error)
        }
      }
    }
    let actionNo = UIAlertAction(title: "Hủy", style: .destructive)
    alert.addTextField { (tf) in
      tf.text = self.userNameLbl.text
      newNameTF = tf
    }
    alert.addAction(actionNo)
    alert.addAction(actionYes)
    present(alert, animated: true, completion: nil)
  }
  
  
  @IBAction func taoPhimBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "goTaoPhim", sender: self)
  }
  var index = 0
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goChiTietPhim" {
      //let indexPath = index
      let controller = segue.destination as! ChiTietPhimVC
      let phim = listPhimUser[index]
      controller.tenPhim = phim.title
      controller.theLoai = phim.genre
      controller.ngayPhatHanh = DSPhimTBVC.dateConvert(date: phim.release)
      controller.ngayTao = DSPhimTBVC.dateConvert(date: phim.createdAt)
      controller.moTa = phim.description
      controller.userID = phim.creatorId
      controller.posterUrl = phim.cover
      controller.phimID = phim.id
      
      
      
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listPhimUser.count
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    index = indexPath.row
    performSegue(withIdentifier: "goChiTietPhim", sender: self)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phimCell", for: indexPath) as? DSPhimUserCell
    let phim = listPhimUser[indexPath.row]
    cell?.titleTF.text = phim.title
    cell?.theLoaiTF.text = phim.genre
    cell?.ngayPhatHanhTF.text = DSPhimTBVC.dateConvert(date: phim.release)
    DSPhimTBVC.downloadImage(posterUrl: phim.cover, imgView: (cell?.posterImg)!)
    return cell!
  }
  
}
