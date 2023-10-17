//
//  JSONParamsEncoder.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public struct JSONParamsEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with stringParams: StringParameters) throws {
        throw RequestError.encodingFailed
    }

    public static func encode(urlRequest: inout URLRequest, with params: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw RequestError.encodingFailed
        }
    }
}
