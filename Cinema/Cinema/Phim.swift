//
//  Phim.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import Foundation

//var count = 0

struct Phim{
    var id : String = ""
    var title : String = ""
    var genre : String = ""
    var release : Double = 0
    var description : String = ""
    var cover : String = ""
    var creatorId : String = ""
    var createdAt : Double = 0
    var user : User = User()


enum PhimCodingKey : String, CodingKey {
    case name, genre, releaseDate, content , posterURL, creatorId, createdDate
    case _id
    case user
}
}
extension Phim: Decodable {
    init(from decoder : Decoder) throws {
//        print("=====", count)
//        count += 1
        let values = try decoder.container(keyedBy: PhimCodingKey.self)
        self.id = try values.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.title = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.genre = try values.decodeIfPresent(String.self, forKey: .genre) ?? ""
        self.release = try values.decodeIfPresent(Double.self, forKey: .releaseDate) ?? 0
        self.description = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
        self.cover = try values.decodeIfPresent(String.self, forKey: .posterURL) ?? ""
        self.creatorId = try values.decodeIfPresent(String.self, forKey: .creatorId) ?? ""
        self.createdAt = try values.decodeIfPresent(Double.self, forKey: .createdDate) ?? 0
        self.user = try values.decodeIfPresent(User.self, forKey: .user) ?? User()
    }
}
