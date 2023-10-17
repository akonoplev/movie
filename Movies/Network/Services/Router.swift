//
//  Router.swift
//  Movies
//
//  Created by Андрей Коноплев on 13.10.2023.
//

import Foundation

public typealias NetworkRouterCompletion = (_ result: Result) -> Void

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 15.0
        let urlSession = URLSession(configuration: sessionConfig)

        do {
            let request = try buildRequest(from: route)
            Logger.logRequest(request: request)
            task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
                Logger.log(response: response as? HTTPURLResponse, data: data, error: error)
                if error != nil {
                    completion(.failure(error!))
                    return
                }

                do {
                    if let data = data, let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                        if let type = json["type"] as? String, type == "error" {
//                            if let messageDict = json["data"] as? [String: Any], let message = messageDict["message"] as? String {
//                                completion(.failure(FoamError(msg: message)))
//                                return
//                            }
//                        }
                    }
                } catch {
                    completion(.failure(ApiError.noData))
                    return
                }


                if let response = response as? HTTPURLResponse {

                    switch response.statusCode {
                    case 200...299:
                        guard let responseData = data else {
                            completion(.failure(ApiError.noData))
                            return
                        }

                        completion(.success(responseData, response))
                    case 401:
                        completion(.failure(ApiError.unauthorize))

                    default:
                        if let error = ApiError.init(rawValue: response.statusCode) {
                            completion(.failure(error))
                        } else {
                            completion(.failure(ApiError.unknown))
                        }

                    }
                }
            })
        } catch {
            completion(.failure(ApiError.unknown))
        }
        task?.resume()
    }

    func cancel() {
        task?.cancel()
    }
}

fileprivate extension Router {

    func buildRequest(from route: EndPoint) throws -> URLRequest {

        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 60.0)

        request.httpMethod = route.httpMethod.rawValue

        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            case .requestWithParams(let bodyParameters, let urlParameters):
                try configureParams(bodyParameters: bodyParameters,
                                    urlParameters: urlParameters,
                                    request: &request)
            case .requestWithParamsAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionalHeaders):
                addAdditionalHeaders(headers: additionalHeaders,
                                     request: &request)
                try configureParams(bodyParameters: bodyParameters,
                                         urlParameters: urlParameters,
                                         request: &request)
            case .requestWithStringParams(stringParameters: let stringParameters):
                try configureStringParams(stringParams: stringParameters, request: &request)
            }
            return request
            } catch {
            throw error
        }
    }

    func configureParams(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParams = bodyParameters {
                try JSONParamsEncoder.encode(urlRequest: &request, with: bodyParams)
            }

            if let urlParams = urlParameters {
                try URLParamsEncoder.encode(urlRequest: &request, with: urlParams)
            }
        } catch {
            throw error
        }
    }

    func configureStringParams(stringParams: StringParameters, request: inout URLRequest) throws {
        do {
            try URLParamsEncoder.encode(urlRequest: &request, with: stringParams)
        } catch {
            throw error
        }
    }

    func addAdditionalHeaders(headers: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = headers else { return }

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
