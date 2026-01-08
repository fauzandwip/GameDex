//
//  APIService.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 09/07/25.
//

import Foundation
import Alamofire
import Combine

enum APIError: Error, LocalizedError {
    case customError(String)
    
    var errorDescription: String? {
        switch self {
        case .customError(let message):
            return "error \(message)"
        }
    }
}

protocol APIServiceProtocol {
    func fetch<T: Codable>(
        endpoint: String,
        inputParameters: [String: String],
        responseType: T.Type
    ) -> AnyPublisher<T, APIError>
}

class APIService: APIServiceProtocol {
    private let apiKey = "ccefeca767674112bc9d8a9fb5247b44"
    private let baseURL = "https://api.rawg.io/api"
    
    func fetch<T: Codable>(
        endpoint: String,
        inputParameters: [String: String],
        responseType: T.Type
    ) -> AnyPublisher<T, APIError> {
        let url = baseURL + endpoint
        var parameters = inputParameters
        parameters["key"] = apiKey
        
        return Future<T, APIError> { promise in
            AF.request(
                url,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default
            )
            .validate()
            .responseDecodable(of: T.self) { res in
                switch res.result {
                case .success(let data):
                    promise(.success(data))
                case .failure(let err):
                    promise(.failure(APIError.customError(err.localizedDescription)))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
