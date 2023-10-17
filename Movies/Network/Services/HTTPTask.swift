//
//  HTTPTask.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestWithParams(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestWithParamsAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, andHeaders: HTTPHeaders?)
    case requestWithStringParams(stringParameters: StringParameters)
}
