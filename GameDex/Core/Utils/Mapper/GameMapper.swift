//
//  GameMapper.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import CoreData

extension GameListResponse {
  func toDomain() -> [GameItem] {
    return self.results.map { $0.toDomain() }
  }
}

extension GameItemResponse {
  func toDomain() -> GameItem {
    GameItem(
      id: self.id,
      name: self.name,
      imageURL: self.backgroundImage,
      rating: self.rating,
      released: self.released
    )
  }
}

extension GameDetailResponse {
  func toDomain() -> GameDetail {
    GameDetail(
      id: self.id,
      name: self.name,
      backgroundImage: self.backgroundImage,
      released: self.released,
      rating: self.rating,
      genres: self.genres?.map { .init(id: $0.id, name: $0.name) },
      description: self.description
    )
  }
}
