//
//  APIService.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 09/07/25.
//

import Foundation
import Alamofire
import Combine

public protocol APIServiceProtocol {
  func fetch<T: Codable & Sendable>(
    endpoint: String,
    inputParameters: [String: String],
    responseType: T.Type
  ) -> AnyPublisher<T, Error>
}

public class APIService: APIServiceProtocol {
  
  public func fetch<T: Codable & Sendable>(
    endpoint: String,
    inputParameters: [String: String],
    responseType: T.Type
  ) -> AnyPublisher<T, Error> {
      guard let apiKey = self.apiKey else {
        return Fail(error: APIError.customError("Need API key"))
          .eraseToAnyPublisher()
      }
      
      var parameters = inputParameters
      parameters["key"] = apiKey
      
      return AF.request(
        endpoint,
        method: .get,
        parameters: parameters,
        encoding: URLEncoding.default
      )
      .validate()
      .publishDecodable(type: T.self)
      .value()
      .mapError { error -> Error in
        APIError.customError(error.localizedDescription)
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
