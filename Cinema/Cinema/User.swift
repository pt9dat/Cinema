//
//  User.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import Foundation

struct User {
    var id : String = ""
    var avatar : String = ""
    var username : String = ""
    var email : String = ""
    var password : String = ""
    



enum UserCodingKey : String, CodingKey {
    case avatarURL, username, email, password
    case _id
}
}
extension User: Decodable {
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKey.self)
        self.id = try values.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.avatar = try values.decodeIfPresent(String.self, forKey: .avatarURL) ?? ""
        self.username = try values.decodeIfPresent(String.self, forKey: .username) ?? ""
        self.email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.password = try values.decodeIfPresent(String.self, forKey: .password) ?? ""
    }
}
