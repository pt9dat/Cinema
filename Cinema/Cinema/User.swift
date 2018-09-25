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
    



enum UserCodingKey : String, CodingKey {
    case avatar, username, email
    case _id
}
}
extension User: Decodable {
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKey.self)
        self.id = try values.decode(String.self, forKey: ._id)
        self.avatar = try values.decode(String.self, forKey: .avatar)
        self.username = try values.decode(String.self, forKey: .username)
        self.email = try values.decode(String.self, forKey: .email)
        
    }
}
