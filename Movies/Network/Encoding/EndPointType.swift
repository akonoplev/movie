//
//  EndPointType.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var header: HTTPHeaders? { get }
}
