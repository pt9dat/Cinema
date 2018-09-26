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

class TaoPhimVC: UIViewController, HSDatePickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
    
    
    

    @IBOutlet weak var chonAnhOutlet: UIButton!
    @IBOutlet weak var taoPhimOutlet: UIButton!
    @IBOutlet weak var tenPhimTF: UITextField!
    @IBOutlet weak var theLoaiTF: UITextField!
    @IBOutlet weak var ngayPhatHanhTF: UITextField!
    @IBOutlet weak var moTaTF: UITextField!
    @IBOutlet weak var theLoaiPickerView: UIPickerView!
    let datePK = HSDatePickerViewController()
    let listTheLoai = ["Hành động", "Tâm lý", "Kinh dị", "Khoa học viễn tưởng", "Hài"]
    
    
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ngayPhatHanhAction(_ sender: UITextField) {
        
        //hsDatePickerPickedDate(datePK.date)
        present(datePK, animated: true, completion: nil)
    }
    
    func hsDatePickerPickedDate(_ date: Date!) {
        print("Date picked \(date)")
        var dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/YYYY"
        ngayPhatHanhTF.text = dateFormater.string(from: date)
        
    }
    
    @IBAction func taoPhimBtn(_ sender: UIButton) {
        var dfmatter = DateFormatter()
        dfmatter.dateFormat="dd/MM/YYYY"
        var date = dfmatter.date(from: ngayPhatHanhTF.text!)
        var dateStamp:TimeInterval = date!.timeIntervalSince1970
        var dateSt:Int = Int(dateStamp)

        let info : [String: Any] = ["name" : tenPhimTF.text!, "genre" : theLoaiTF.text!, "releaseDate" : dateSt, "content" : moTaTF.text!]
        let jsonURLString = "https://cinema-hatin.herokuapp.com/api/cinema/"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url, method: .post, parameters: info, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success:
                print(response)
                print(dateSt)
                //self.performSegue(withIdentifier: "goDangNhap", sender: self)
                break
            case .failure(let error):
                
                print(error)
                
            }
        
        
    }

       
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return listTheLoai.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return listTheLoai[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.theLoaiTF.text = self.listTheLoai[row]
        self.theLoaiPickerView.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.theLoaiTF {
            self.theLoaiPickerView.isHidden = false
            //if you don't want the users to se the keyboard type:
            
            textField.endEditing(true)
        }
    }

}
