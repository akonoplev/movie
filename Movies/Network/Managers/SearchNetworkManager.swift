//
//  SearchNetworkService.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

protocol SearchNetworkManagerProtocol {
    func searchMovie(
        searchSring: String,
        page: Int,
        success: @escaping (_ response: SearchResponse) -> Void,
        failure: @escaping (_ error: Error) -> Void
    )
}

class SearchNetworkManager: SearchNetworkManagerProtocol {

    private let router = Router<SearchEndPoint>()

    func searchMovie(
        searchSring: String,
        page: Int,
        success: @escaping (_ response: SearchResponse) -> Void,
        failure: @escaping (_ error: Error) -> Void
    ) {
        router.request(.search(searchText: searchSring, page: page)) { (result) in
            switch result {
            case let .success(data, _):
                do {
                    let response = try JSONDecoder().decode(SearchResponse.self, from: data)
                    success(response)
                } catch {
                    failure(ApiError.internalError)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
