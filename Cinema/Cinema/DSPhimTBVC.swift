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

    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.register(UINib(nibName: "DSPhimCell", bundle: nil), forCellReuseIdentifier: "phimCell1")
        tbView.delegate = self
        tbView.dataSource = self
        seachBarOutlet.delegate = self
        parseJSON()
        //self.tableView.register(customCeViewll.self, forCellReuseIdentifier: "cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        parseJSON()
        print("reload Data")
    }

    // MARK: - Table view data source
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "goTaoPhim", sender: self)
    }
    

    @IBAction func dangXuatBtn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Xác nhận", message: "Bạn có muốn đăng xuất?", preferredStyle: .alert)
        // actions
        let yesBtn = UIAlertAction(title: "Có", style: .default) { (btn) in
            
            
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
        }
        let noBtn = UIAlertAction(title: "Không", style: .destructive) { (btn) in
            print("Không")
        }
        alert.addAction(yesBtn)
        alert.addAction(noBtn)
        
        
        present(alert, animated: true, completion: nil)
        
        
        
        
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
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goChiTietPhim", sender: self)
    }
    
    func getImage(posterUrl:String)->UIImage {
        let url = baseURL + posterUrl
        var img = UIImage()
        Alamofire.request(url, method: .get).responseData { response in
            if let data = response.result.value {
                img = UIImage(data: data)!
                print("OK IMG")
            } else {
                print("error")
            }
        }
        return img
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
        cell.imgIV.image = getImage(posterUrl: phim.cover)
        
        return cell
    }
}
