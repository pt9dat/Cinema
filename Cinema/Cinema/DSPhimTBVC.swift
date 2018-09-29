//
//  DSPhimTBVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire

class DSPhimTBVC:  UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var seachBarOutlet: UISearchBar!
    var listPhim = [Phim]()
    var filterData = [Phim]()
    var isSearching = false

    @IBOutlet weak var userInfoOutlet: UIButton!
    @IBOutlet weak var taoPhimOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.register(UINib(nibName: "DSPhimCell", bundle: nil), forCellReuseIdentifier: "phimCell1")
        tbView.delegate = self
        tbView.dataSource = self
        seachBarOutlet.delegate = self
        parseJSON()
        
        taoPhimOutlet.frame = CGRect(x: 295, y: 595, width: 60, height: 60)
        taoPhimOutlet.setTitle("+", for: .normal)
        taoPhimOutlet.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        taoPhimOutlet.clipsToBounds = true
        taoPhimOutlet.layer.cornerRadius = 30
        taoPhimOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        taoPhimOutlet.layer.borderWidth = 3.0
        taoPhimOutlet.layer.shadowRadius = 5
        taoPhimOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        taoPhimOutlet.layer.masksToBounds = false
        taoPhimOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        taoPhimOutlet.layer.shadowOpacity = 1.0
        
        userInfoOutlet.frame = CGRect(x: 25, y: 595, width: 60, height: 60)
        userInfoOutlet.setTitle("U", for: .normal)
        userInfoOutlet.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userInfoOutlet.clipsToBounds = true
        userInfoOutlet.layer.cornerRadius = 30
        userInfoOutlet.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userInfoOutlet.layer.borderWidth = 3.0
        userInfoOutlet.layer.shadowRadius = 5
        userInfoOutlet.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userInfoOutlet.layer.masksToBounds = false
        userInfoOutlet.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        userInfoOutlet.layer.shadowOpacity = 1.0
        
        //self.tableView.register(customCeViewll.self, forCellReuseIdentifier: "cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tbView.bounces = true
        UIApplication.shared.statusBarStyle = .lightContent
        parseJSON()
        print("reload Data")
        if DangNhapVC.userDefault.string(forKey: "userID") == nil {
            userInfoOutlet.isHidden = true
        } else {
            userInfoOutlet.isHidden = false
        }
    }

   
    
    @IBAction func taoPhimBtn(_ sender: UIButton) {
        print(DangNhapVC.userDefault.string(forKey: "token"))
        if DangNhapVC.userDefault.string(forKey: "userID") != nil {
         performSegue(withIdentifier: "goTaoPhim", sender: self)
        } else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn phải đăng nhập mới thực hiện được chức năng này.", preferredStyle: .alert)
            // actions
            let yesBtn = UIAlertAction(title: "Đăng nhập", style: .default) { (btn) in
                
                
                self.performSegue(withIdentifier: "goDangNhap", sender: self); //self.navigationController?.popViewController(animated: true)
                //self.dismiss(animated: true, completion: nil)
                
                
                
            }
            let noBtn = UIAlertAction(title: "Hủy", style: .destructive) { (btn) in
                print("Không")
            }
            alert.addAction(yesBtn)
            alert.addAction(noBtn)
            
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    func parseJSON() {
        let jsonURLString = baseURL + "/api/cinema"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url).responseJSON { [weak self](response) in
            guard let `self` = self else { return }
            if response.result.isSuccess {
                guard let list = try? JSONDecoder().decode(ListFilm.self, from: response.data!) else {
                    print("error load")
                    return
                    
                }
               
                self.listPhim = list.movies
                
                self.tbView.reloadData()
                
               
                    
                
            } else {
                print("ERROR: \(response.result.error)")
                
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            //view.endEditing(true)
            tbView.reloadData()
        } else {
            isSearching = true
            for phim in listPhim {
                
                filterData = listPhim.filter({ (phim) -> Bool in
                    return phim.title.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil).contains(searchText.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil)) || dateConvert(date: phim.release).folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil).contains(searchText.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil)) || dateConvert(date: phim.createdAt).folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil).contains(searchText.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil)) || phim.description.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil).contains(searchText.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: nil))
                    })
                tbView.reloadData()
                }
            
        
        }
    }
    
    
    func dateConvert(date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
//        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    var index = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "goChiTietPhim", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goChiTietPhim" {
            //let indexPath = index
                let controller = segue.destination as! ChiTietPhimVC
                let phim = listPhim[index]
                controller.tenPhim = phim.title
                controller.theLoai = phim.genre
                controller.ngayPhatHanh = dateConvert(date: phim.release)
                controller.ngayTao = dateConvert(date: phim.createdAt)
                controller.moTa = phim.description
                controller.userID = phim.creatorId
                
            
        }
        if segue.identifier == "goUserInfo" {
            
            let controller = segue.destination as! UserVC
            for phim in listPhim {
                if phim.creatorId == DangNhapVC.userDefault.string(forKey: "userID") {
                    controller.listPhimUser.append(phim)
                }
            }
        }
        
    }
    
  
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        func downloadImage(posterUrl:String, imgView: UIImageView) {
            let imgUrl = baseURL + posterUrl
            if let url = URL(string: imgUrl) {
            print("Download Started")
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    imgView.image = UIImage(data: data)
                }
                }
                
    } else {
    imgView.image = UIImage(named: "195151")
            }
        }
        
//        Alamofire.request(url).responseData { response in
//            if let data = response.data {
//                img = UIImage(data: data) ?? UIImage(named: "195151")!
//                print("OK IMG: \(response.data)")
//            } else {
//                print("error")
//            }
//        }
   
    
    @IBAction func userInfoBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goUserInfo", sender: self)
            
    }
    
    

}
extension DSPhimTBVC {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


extension DSPhimTBVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterData.count
        }
        return listPhim.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "phimCell1") as! DSPhimCell
        //render data
        let phim : Phim
        if isSearching {
            phim = filterData[indexPath.row]
        } else {
            phim = listPhim[indexPath.row]
        }
        cell.tenPhimTF.text = phim.title
        cell.theLoaiTF.text = phim.genre
        cell.userTF.text = phim.description
        cell.dateTF.text = dateConvert(date: phim.release)
        
        downloadImage(posterUrl: phim.cover, imgView: cell.imgIV)
        return cell
    }
}

