//
//  File.swift
//  Core
//
//  Created by Fauzan Dwi Prasetyo on 30/01/26.
//

import Factory

extension Container {
  
  public var apiService: Factory<APIServiceProtocol> {
    self { APIService() }
  }
  
}
