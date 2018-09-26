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
    var id : String
    var title : String
    var genre : String
    var release : String
    var description : String
    var cover : String
    var creatorId : String
    var createdAt : String
    var user : User


enum PhimCodingKey : String, CodingKey {
    case title, genre, release, description, cover, creatorId, createdAt
    case _id
    case creator
}
}
extension Phim: Decodable {
    init(from decoder : Decoder) throws {
//        print("=====", count)
//        count += 1
        let values = try decoder.container(keyedBy: PhimCodingKey.self)
        self.id = try values.decodeIfPresent(String.self, forKey: ._id) ?? ""
        self.title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.genre = try values.decodeIfPresent(String.self, forKey: .genre) ?? ""
        self.release = try values.decodeIfPresent(String.self, forKey: .release) ?? ""
        self.description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.cover = try values.decodeIfPresent(String.self, forKey: .cover) ?? ""
        self.creatorId = try values.decodeIfPresent(String.self, forKey: .creatorId) ?? ""
        self.createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.user = try values.decodeIfPresent(User.self, forKey: .creator) ?? User()
    }
}
