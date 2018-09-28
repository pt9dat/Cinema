//
//  UserVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/28/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit

class UserVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var doiMatKhauOutlet: UIButton!
    @IBOutlet weak var dangXuatOutlet: UIButton!
    @IBOutlet weak var avatarOutlet: UIButton!
    @IBOutlet weak var userNameOutlet: UIButton!
    
    var avatar = UIImage()
    let imgPicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        imgPicker.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        userNameOutlet.setTitle(DangNhapVC.userDefault.string(forKey: "userName"), for: .normal)
    }
    
    @IBAction func doiMatKhauBtn(_ sender: UIButton) {
        var oldPassTF = UITextField()
        var newPassTF = UITextField()
        var confNewPassTF = UITextField()
        let alert = UIAlertController(title: "Đổi mật khẩu", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Đổi", style: .default) { (action) in
//            let newItem = Item()
//            newItem.title = textField.text!
//            self.itemArray.append(newItem)
//            self.saveItems()
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Mật khẩu hiện tại"
            oldPassTF = tf
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Mật khẩu mới"
            newPassTF = tf
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Nhập lại mật khẩu mới"
            confNewPassTF = tf
        }
        alert.addAction(action)
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
        alert.addAction(yesBtn)
        alert.addAction(noBtn)
        
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarOutlet.imageView?.contentMode = .scaleAspectFit
            avatarOutlet.setImage(pickedImage, for: .normal)
            avatar = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userNameBtn(_ sender: Any) {
        var newNameTF = UITextField()
        let alert = UIAlertController(title: "Đổi tên user", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Đổi", style: .default) { (action) in
            //            let newItem = Item()
            //            newItem.title = textField.text!
            //            self.itemArray.append(newItem)
            //            self.saveItems()
        }
        alert.addTextField { (tf) in
            tf.placeholder = "Nhập tên muốn đổi"
            newNameTF = tf
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
