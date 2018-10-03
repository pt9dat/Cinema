//
//  customCell.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit

class DSPhimCell: UITableViewCell {
  // MARK: - Class's Property
  @IBOutlet weak var imgIV: UIImageView!
  @IBOutlet weak var tenPhimTF: UILabel!
  @IBOutlet weak var theLoaiTF: UILabel!
  @IBOutlet weak var dateTF: UILabel!
  @IBOutlet weak var moTaTF: UILabel!
  @IBOutlet weak var userNameTF: UILabel!
  
  // MARK: - UITableViewCell's methods
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
