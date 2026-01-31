//
//  File.swift
//  Core
//
//  Created by Fauzan Dwi Prasetyo on 30/01/26.
//

import Combine

public protocol GameRepositoryProtocol {
  func getList(
    search: String,
    sort: Sort
  ) -> AnyPublisher<[GameItem], Error>
  
  func getDetail(id: Int) -> AnyPublisher<GameDetail, Error>
  func getFavoriteGames() -> AnyPublisher<[GameItem], Error>
  func isFavorite(id: Int) -> AnyPublisher<Bool, Never>
  func updateFavorite(game: GameDetail) -> AnyPublisher<Bool, Error>
  func removeFavorite(id: Int) -> AnyPublisher<Bool, Error>
}
