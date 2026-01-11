//
//  APICall.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 10/01/26.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case games
    case game(id: Int)
    
    public var url: String {
      switch self {
      case .games:
        return "\(API.baseUrl)/games"
      case .game(let id):
        return "\(API.baseUrl)/games/\(id)"
      }
    }
  }
}
