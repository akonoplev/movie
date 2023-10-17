//
//  NetworkError.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public enum ApiError: Int, Error {
    case unknown
    case noData
    case internalError
    case unauthorize = 401
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {

        case .unknown:
            NSLocalizedString("Unknown error", comment: "")
        case .noData:
            NSLocalizedString("There is no data in server response", comment: "")
        case .internalError:
            NSLocalizedString("Internal movie app error", comment: "")
        case .unauthorize:
            NSLocalizedString("Aurhorization is failed", comment: "")
        }
    }
}
