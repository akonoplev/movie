//
//  NetworkAssembly.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import EasyDi

final class NetworkServicesAssembley: Assembly {

    var searchNetworkManager: SearchNetworkManagerProtocol {
        define(scope: .lazySingleton, init: SearchNetworkManager())
    }

    var operationManager: OperationManagerProtocol {
        define(scope: .lazySingleton, init: OperationManager(
            networkAssembly: self
        ))
    }
}
