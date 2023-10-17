//
//  OperationManager.swift
//  Movies
//
//  Created by Андрей Коноплев on 15.10.2023.
//

import Foundation

protocol OperationManagerProtocol {
    func search(
        searchText: String,
        page: Int,
        success: @escaping (_ response: SearchResponse) -> Void,
        failire: @escaping (_ error: Error) -> Void
    )
}

final class OperationManager: OperationManagerProtocol {

    private let networkAssembly: NetworkServicesAssembley

    init(networkAssembly: NetworkServicesAssembley!) {
        self.networkAssembly = networkAssembly
    }

    func search(
        searchText: String,
        page: Int,
        success: @escaping (_ response: SearchResponse) -> Void,
        failire: @escaping (_ error: Error) -> Void
    ) {
        let operation = SearchOperation(searchText: searchText, 
                                        page: page,
                                        searchManager: networkAssembly.searchNetworkManager,
                                        success: success,
                                        failure: failire)
        OperationService.addOperation(op: operation, cancelingQueue: true)
    }

    func cancelAllOperations() {
        OperationService.cancelAllOperation()
    }
}
