//
//  LoginUser.swift
//  Cinema
//
//  Created by ChinhDat on 9/26/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import Foundation
struct LoginToken {
    var token : String
    var loginUser : LoginUser
    
    enum LoginCodingKeys: String, CodingKey {
        case token
        case user
        

    }

}

extension LoginToken: Decodable {
     init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: LoginCodingKeys.self)
        self.token = try values.decode(String.self, forKey: .token)
        self.loginUser = try values.decode(LoginUser.self, forKey: .user)
        }
}

