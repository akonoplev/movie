//
//  SearchOperation.swift
//  Movies
//
//  Created by Андрей Коноплев on 15.10.2023.
//

import Foundation

final class SearchOperation: Operation {

    private let searchText: String
    private let page: Int
    private let searchManager: SearchNetworkManagerProtocol
    private let success: (_ response: SearchResponse) -> Void
    private let failure: (_ error: Error) -> Void

    init(
        searchText: String,
        page: Int,
        searchManager: SearchNetworkManagerProtocol,
        success: @escaping (_ response: SearchResponse) -> Void,
        failure: @escaping (_ error: Error) -> Void
    ) {
        self.searchText = searchText
        self.page = page
        self.searchManager = searchManager
        self.success = success
        self.failure = failure
    }

    deinit {
        print("deinit search")
    }

    override func main() {
        super.main()

        let dispatchSemaphore = DispatchSemaphore(value: 0)

        searchManager.searchMovie(searchSring: searchText, page: page) { [weak self] response in
            guard let self = self, !self.isCancelled else {
                dispatchSemaphore.signal()
                return
            }
            self.success(response)
            dispatchSemaphore.signal()
        } failure: { [weak self] error in
            guard let self = self, !self.isCancelled else {
                dispatchSemaphore.signal()
                return
            }
            guard !self.isCancelled else { return }
            self.failure(error)
            dispatchSemaphore.signal()
        }

        _ = dispatchSemaphore.wait(timeout: .distantFuture)
    }
}
