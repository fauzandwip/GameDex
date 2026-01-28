//
//  APIService.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 09/07/25.
//

import Foundation
import Alamofire
import Combine

protocol APIServiceProtocol {
  func fetch<T: Codable>(
    endpoint: String,
    inputParameters: [String: String],
    responseType: T.Type
  ) -> AnyPublisher<T, Error>
}

class APIService: APIServiceProtocol {
  
  func fetch<T: Codable>(
    endpoint: String,
    inputParameters: [String: String],
    responseType: T.Type
  ) -> AnyPublisher<T, Error> {
    return Future<T, Error> { promise in
      guard let apiKey = self.apiKey else {
        promise(.failure(APIError.customError("Need API key")))
        return
      }
      
      var parameters = inputParameters
      parameters["key"] = apiKey
      
      AF.request(
        endpoint,
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

extension APIService {
  private var apiKey: String? {
    guard let filePath = Bundle.main.path(forResource: "RAWG-Info", ofType: "plist") else {
      print("Couldn't find file 'RAWG-Info.plist'.")
      return nil
    }
    
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "RAWG_API_KEY") as? String else {
      print("Couldn't find key 'RAWG_API_KEY' in 'RAWG-Info.plist'.")
      return nil
    }
    
    if value.starts(with: "_") {
      print("Register for a RAWG developer account and get an API key at https://rawg.io/apidocs.")
      return nil
    }
    
    return value
  }
}
