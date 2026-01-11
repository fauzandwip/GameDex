//
//  CustomError+Ext.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 10/01/26.
//

import Foundation

enum APIError: Error, LocalizedError {
  case customError(String)

  var errorDescription: String? {
    switch self {
    case .customError(let message):
      return "error \(message)"
    }
  }
}
