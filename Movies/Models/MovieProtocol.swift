//
//  MovieProtocol.swift
//  Movies
//
//  Created by Андрей Коноплев on 16.10.2023.
//

import Foundation

protocol MovieProtocol {
    var id: Int? { get }
    var title: String? { get }
    var overview: String? { get }
    var release_date: String? { get }
    var poster_path: String? { get }
}
