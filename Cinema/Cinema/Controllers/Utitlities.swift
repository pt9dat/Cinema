//
//  Utitlities.swift
//  Cinema
//
//  Created by ChinhDat on 10/3/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import UIKit

// MARK: - Download Image
func downloadImage(posterUrl:String, imgView: UIImageView) {
  let imgUrl = baseURL + posterUrl
  let url = URL(string: imgUrl)
  imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "195151"))
}

// MARK: - Date Convert
func dateConvert(date: Double) -> String {
  let date = Date(timeIntervalSince1970: date)
  let dateFormatter = DateFormatter()
  //        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
  //        dateFormatter.locale = NSLocale.current
  dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
  let strDate = dateFormatter.string(from: date)
  return strDate
}

// MARK: - Validate email
func isValidEmail(testStr:String) -> Bool {
  let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
  return emailTest.evaluate(with: testStr)
}
