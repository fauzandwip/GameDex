//
//  FavoriteListUseCase.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import Combine
import Game

protocol FavoriteListUseCase {
  func getList() -> AnyPublisher<[GameItem], Error>
  func deleteGame(id: Int) -> AnyPublisher<Bool, Error>
}

final class FavoriteListInteractor: FavoriteListUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func getList() -> AnyPublisher<[GameItem], Error> {
    gameRepository.getFavoriteGames()
  }
  
  func deleteGame(id: Int) -> AnyPublisher<Bool, Error> {
    gameRepository.removeFavorite(id: id)
  }
}
