//
//  SearchResponse.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public struct SearchResponse: Codable {
    let page: Int
    let total_pages: Int
    let total_results: Int
    let results: [Movie]
}
