//
//  Query.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

struct Query: Equatable {
  let search: String
  let sort: Sort
}

enum Sort: String, CaseIterable, Identifiable {
  case latest, oldest
  var id: String { self.rawValue }
}
