//
//  LoginUser.swift
//  Cinema
//
//  Created by ChinhDat on 9/26/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import Foundation
struct LoginUser {
    var id : String = ""
    var email : String = ""
    var name : String = ""
    
    enum UserCodingKeys: String, CodingKey {
        case _id
        case email, name
        }
}

extension LoginUser: Decodable {
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
