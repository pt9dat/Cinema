//
//  DSPhimTBVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class DSPhimTBVC:  UIViewController, UISearchBarDelegate {
  
  // MARK: - Class's Property
  @IBOutlet weak var tbView: UITableView!
  @IBOutlet weak var seachBarOutlet: UISearchBar!
  @IBOutlet weak var userInfoOutlet: UIButton!
  @IBOutlet weak var taoPhimOutlet: UIButton!
  
  var listPhim = [Phim]()
  var filterData = [Phim]()
  var isSearching = false
  let refreshControl = UIRefreshControl()
  var index = 0
  
  // MARK: - UIViewController's methods
  fileprivate func configUI() {
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
    
    refreshControl.tintColor = .white
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tbView.register(UINib(nibName: "DSPhimCell", bundle: nil), forCellReuseIdentifier: "phimCell1")
    tbView.delegate = self
    tbView.dataSource = self
    seachBarOutlet.delegate = self
    
    configUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UIApplication.shared.statusBarStyle = .lightContent
    parseJSON()
    print("reload Data")
    
    if let _ = userDefault.string(forKey: "userID") {
      userInfoOutlet.isHidden = false
    } else {
      userInfoOutlet.isHidden = true
    }
    
    tbView.bounces = true
    tbView.refreshControl = refreshControl
    refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
  }
  
  @objc func updateData() {
    // self.number += 1
    parseJSON()
    refreshControl.endRefreshing()
  }
}

// MARK: - Buttons's actions
extension DSPhimTBVC {
  // Tao phim
  @IBAction func taoPhimBtn(_ sender: UIButton) {
    print(userDefault.string(forKey: "token"))
    if userDefault.string(forKey: "userID") != nil {
      performSegue(withIdentifier: "goTaoPhim", sender: self)
    } else {
      let alert = UIAlertController(title: "Thông báo", message: "Bạn phải đăng nhập mới thực hiện được chức năng này.", preferredStyle: .alert)
      let yesBtn = UIAlertAction(title: "Đăng nhập", style: .default) { (btn) in
        self.performSegue(withIdentifier: "goDangNhap", sender: self);
      }
      let noBtn = UIAlertAction(title: "Hủy", style: .destructive) { (btn) in
        print("Không")
      }
      alert.addAction(noBtn)
      alert.addAction(yesBtn)
      present(alert, animated: true, completion: nil)
    }
  }
  
  // User Info
  @IBAction func userInfoBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "goUserInfo", sender: self)
  }
}

// MARK: - SearchBar's methods
extension DSPhimTBVC {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchBar.text == nil || searchBar.text == "" {
      isSearching = false
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
}

// MARK: - Segue's methods
extension DSPhimTBVC{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goChiTietPhim" {
      let controller = segue.destination as! ChiTietPhimVC
      let phim = listPhim[index]
      controller.tenPhim = phim.title
      controller.theLoai = phim.genre
      controller.ngayPhatHanh = dateConvert(date: phim.release)
      controller.ngayTao = dateConvert(date: phim.createdAt)
      controller.moTa = phim.description
      controller.userID = phim.creatorId
      controller.posterUrl = phim.cover
      controller.phimID = phim.id
      controller.nguoiTao = phim.user.username
    }
    if segue.identifier == "goUserInfo" {
      let controller = segue.destination as! UserVC
      for phim in listPhim {
        if phim.creatorId == userDefault.string(forKey: "userID") {
          controller.listPhimUser.append(phim)
        }
      }
    }
  }
}

// MARK: - UITableViewDelegate's methods
extension DSPhimTBVC: UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
}

// MARK: - UITableViewDataSource's methods
extension DSPhimTBVC: UITableViewDataSource {
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
    cell.userNameTF.text = phim.user.username
    cell.moTaTF.text = phim.description
    cell.dateTF.text = dateConvert(date: phim.release)
    downloadImage(posterUrl: phim.cover, imgView: cell.imgIV)
    return cell
  }
}

// MARK: - UITableView's functions
extension DSPhimTBVC {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    index = indexPath.row
    performSegue(withIdentifier: "goChiTietPhim", sender: self)
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
}

