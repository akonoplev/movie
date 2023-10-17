//
//  MovieItem.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

struct Movie: Codable, MovieProtocol {
    let id: Int?
    var title: String?
    var overview: String?
    var release_date: String?
    var poster_path: String?
}
