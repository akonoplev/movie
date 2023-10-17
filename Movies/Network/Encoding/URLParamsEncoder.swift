//
//  URLParamsEncoder.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public struct URLParamsEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with params: Parameters) throws {
        guard let url = urlRequest.url else { throw RequestError.urlNotFound }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !params.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()

            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }

    public static func encode(urlRequest: inout URLRequest, with stringParams: StringParameters) throws {
        guard let url = urlRequest.url else { throw RequestError.urlNotFound }

        if stringParams != "", let filanlUrl = URL(string: url.absoluteString + stringParams) {
            urlRequest.url = filanlUrl
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
