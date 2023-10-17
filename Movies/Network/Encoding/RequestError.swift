//
//  RequestError.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public enum RequestError: String, Error {
    case paramssNil = "Parameters were nil"
    case encodingFailed = "Params encoding failed"
    case urlNotFound = "URL not found"
}
