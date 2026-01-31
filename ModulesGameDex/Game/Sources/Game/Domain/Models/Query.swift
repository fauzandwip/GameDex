//
//  Query.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

public struct Query: Equatable {
  public let search: String
  public let sort: Sort
  
  public init(search: String, sort: Sort) {
    self.search = search
    self.sort = sort
  }
}

public enum Sort: String, CaseIterable, Identifiable {
  case latest, oldest
  public var id: String { self.rawValue }
}
