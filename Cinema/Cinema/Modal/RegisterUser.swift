//
//  RegisterUser.swift
//  Cinema
//
//  Created by ChinhDat on 9/28/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import Foundation
struct RegisterUser {
    var user : LoginUser
    
    enum UserCodingKeys: String, CodingKey {
        case user
    }
}

extension RegisterUser: Decodable {
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKeys.self)
        self.user = try values.decode(LoginUser.self, forKey: .user)
        
    }
}
