//
//  ParameterEncoding.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias StringParameters = String

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with params: Parameters) throws
    static func encode(urlRequest: inout URLRequest, with stringParams: StringParameters) throws
}
