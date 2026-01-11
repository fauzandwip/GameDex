//
//  GameDetailUseCase.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import Combine

protocol GameDetailUseCase {
  func getGame(id: Int) -> AnyPublisher<GameDetail, Error>
  func isFavorite(id: Int) -> AnyPublisher<Bool, Never>
  func updateFavorite(game: GameDetail) -> AnyPublisher<Bool, Error>
}

final class GameDetailInteractor: GameDetailUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func getGame(id: Int) -> AnyPublisher<GameDetail, Error> {
    gameRepository.getDetail(id: id)
  }
  
  func isFavorite(id: Int) -> AnyPublisher<Bool, Never> {
    gameRepository.isFavorite(id: id)
  }
  
  func updateFavorite(game: GameDetail) -> AnyPublisher<Bool, Error> {
    gameRepository.updateFavorite(game: game)
  }
}
