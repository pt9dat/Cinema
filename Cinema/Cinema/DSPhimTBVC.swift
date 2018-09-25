//
//  DSPhimTBVC.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit
import Alamofire

class DSPhimTBVC: UITableViewController {
    
    var listPhim = [Phim]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "DSPhimCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        parseJSON()
        //self.tableView.register(customCell.self, forCellReuseIdentifier: "cell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DSPhimCell
     //render data
       

        return cell
    }
    
    
    func parseJSON() {
        let jsonURLString = "https://nam-cinema.herokuapp.com/api/v1/movies/"
        guard let url = URL(string: jsonURLString) else {return}
        Alamofire.request(url).responseJSON { [weak self](response) in
            guard let `self` = self else { return }
            if response.result.isSuccess {
                guard let list = try? JSONDecoder().decode(ListFilm.self, from: response.data!) else {
                    print("error")
                    return
                    
                }
                print(list)
                
                self.tableView.reloadData()
                
               
                    
                
            } else {
                print("ERROR: \(response.result.error)")
                
            }
        }
           
        
        
        
        
//        let jsonURLString = "https://nam-cinema.herokuapp.com/api/v1/movies/"
//        guard let url = URL(string: jsonURLString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, res, err) in
//            guard let data = data else {return}
//            let dataAsString = String(data: data, encoding: .utf8)
//            print(dataAsString)
//
//        }.resume()
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

}
extension DSPhimTBVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
