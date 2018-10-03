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

class UserVC: UIViewController {
  // MARK: - Class's Property
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
  var index = 0
  let refreshControl = UIRefreshControl()
  lazy var headers: HTTPHeaders = [
    "x-access-token": token!
  ]
  
  // MARK: - UIViewController's methods
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
    
    refreshControl.tintColor = .white
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    
    imgPicker.delegate = self
    dsPhimView.delegate = self
    dsPhimView.dataSource = self
    
    scrollViewOutlet.isScrollEnabled = true
    scrollViewOutlet.alwaysBounceVertical = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    userNameLbl.text = userDefault.string(forKey: "userName")
    emailLbl.text = userDefault.string(forKey: "userEmail")
    token = userDefault.string(forKey: "token")
    
    let url = URL(string: baseURL + listPhimUser[0].user.avatar)
    avatarOutlet.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named: "195151"))
    
    
    scrollViewOutlet.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
  }
  
  // Update Data
  @objc func updateData() {
    reloadUserInfo()
    reloadListPhim()
    refreshControl.endRefreshing()
  }
  
  // Reload data of list phim
  func reloadListPhim () {
    guard let url = URL(string: baseURL + "/api/cinema") else {return}
    Alamofire.request(url).responseJSON { [weak self](response) in
      guard let `self` = self else { return }
      if response.result.isSuccess {
        guard let list = try? JSONDecoder().decode(ListFilm.self, from: response.data!) else {
          print("error load")
          return
        }
        self.listPhimUser = list.movies.filter({ (phim) -> Bool in
          return phim.creatorId == userDefault.string(forKey: "userID")
        })
        self.dsPhimView.reloadData()
      } else {
        print("fail")
      }
    }
  }
  
  // Reload user info
  func reloadUserInfo() {
    let info : [String : String] = ["token" : userDefault.string(forKey: "token")!]
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
        userDefault.set(getUser.username, forKey: "userName")
        self.userNameLbl.text = userDefault.string(forKey: "userName")
        break
      case .failure(let error):
        print(error)
      }
    }
  }
}

// MARK: - Button's action
extension UserVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBAction func doiMatKhauBtn(_ sender: UIButton) {
    var oldPassTF = UITextField()
    var newPassTF = UITextField()
    var confNewPassTF = UITextField()
    let alert = UIAlertController(title: "Đổi mật khẩu", message: "", preferredStyle: .alert)
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
  
  // Dang xuat
  @IBAction func dangXuatBtn(_ sender: UIButton) {
    let alert = UIAlertController(title: "Xác nhận", message: "Bạn có muốn đăng xuất?", preferredStyle: .alert)
    // actions
    let yesBtn = UIAlertAction(title: "Có", style: .default) { (btn) in
      userDefault.removeObject(forKey: "token")
      userDefault.removeObject(forKey: "userID")
      userDefault.removeObject(forKey: "userName")
      userDefault.removeObject(forKey: "userEmail")
      self.performSegue(withIdentifier: "goDangNhap", sender: self);
    }
    let noBtn = UIAlertAction(title: "Không", style: .destructive) { (btn) in
      print("Không")
    }
    alert.addAction(noBtn)
    alert.addAction(yesBtn)
    present(alert, animated: true, completion: nil)
  }
  
  // Back
  @IBAction func backBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    self.dismiss(animated: true, completion: nil)
  }
  
  // Doi avatar
  @IBAction func doiAvatarBtn(_ sender: UIButton) {
    imgPicker.allowsEditing = false
    imgPicker.sourceType = .photoLibrary
    present(imgPicker, animated: true, completion: nil)
  }
  
  // Doi user name
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
            userDefault.removeObject(forKey: "userName")
            userDefault.set(newNameTF.text, forKey: "userName")
            self.userNameLbl.text = newNameTF.text
          } else {
            self.view.makeToast("Lỗi.")
            break
          }
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
  // Tao phim
  @IBAction func taoPhimBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "goTaoPhim", sender: self)
  }
}

// MARK: - Segue's methods
extension UserVC {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goChiTietPhim" {
      let controller = segue.destination as! ChiTietPhimVC
      let phim = listPhimUser[index]
      controller.tenPhim = phim.title
      controller.theLoai = phim.genre
      controller.ngayPhatHanh = dateConvert(date: phim.release)
      controller.ngayTao = dateConvert(date: phim.createdAt)
      controller.moTa = phim.description
      controller.userID = phim.creatorId
      controller.posterUrl = phim.cover
      controller.phimID = phim.id
    }
  }
}

// MARK: - UIImagePickerController's methods
extension UserVC {
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
}

// MARK: - UICollectionViewDelegate's method
extension UserVC: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    index = indexPath.row
    performSegue(withIdentifier: "goChiTietPhim", sender: self)
  }
}

// MARK: - UICollectionViewDataSource's method
extension UserVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return listPhimUser.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phimCell", for: indexPath) as? DSPhimUserCell
    let phim = listPhimUser[indexPath.row]
    cell?.titleTF.text = phim.title
    cell?.theLoaiTF.text = phim.genre
    cell?.ngayPhatHanhTF.text = dateConvert(date: phim.release)
    downloadImage(posterUrl: phim.cover, imgView: (cell?.posterImg)!)
    return cell!
  }
}
