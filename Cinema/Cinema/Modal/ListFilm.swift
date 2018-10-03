//
//  ListFilm.swift
//  Cinema
//
//  Created by ChinhDat on 9/25/18.
//  Copyright © 2018 ChinhDat. All rights reserved.
//

import Foundation

struct ListFilm {
    var movies=[Phim]()
    
    enum FilmCodingKeys: String, CodingKey {
        case films
    }
}

extension ListFilm: Decodable {
        init(from decoder : Decoder) throws {
            let values = try decoder.container(keyedBy: FilmCodingKeys.self)
            self.movies = try values.decodeIfPresent([Phim].self, forKey: .films) ?? [Phim]()
            
        }
    
}
