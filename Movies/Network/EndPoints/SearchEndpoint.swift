//
//  SearchEndpoint.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

enum SearchEndPoint: EndPointType {
    case search(searchText: String, page: Int)
}

extension SearchEndPoint {
    var baseUrl: URL {
        return URL(string: GlobalConstants.API.baseURL)!
    }

    var path: String {
        switch self {
        case .search:
            return "/search/movie"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .search:
            return .GET
        }
    }

    var task: HTTPTask {
        switch self {
        case let .search(searchText, page):
            var params: [String: Any] = [:]
            params["query"] = searchText
            params["api_key"] = GlobalConstants.API.apiKey
            params["page"] = page
            return .requestWithParams(bodyParameters: nil, urlParameters: params)
        }
    }

    var header: HTTPHeaders? {
        return nil
    }
}
