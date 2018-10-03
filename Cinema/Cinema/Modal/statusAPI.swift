//
//  statusAPI.swift
//  Cinema
//
//  Created by ChinhDat on 10/1/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import Foundation
struct statusAPI {
    var status : Int = 0
    
    enum StatusCodingKey : String, CodingKey {
        case status
}
}
    extension statusAPI: Decodable {
        init(from decoder : Decoder) throws {
            let values = try decoder.container(keyedBy: StatusCodingKey.self)
            self.status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 0
}
}
