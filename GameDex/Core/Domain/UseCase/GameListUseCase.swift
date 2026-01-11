//
//  GameListUseCase.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 10/01/26.
//

import Combine

protocol GameListUseCase {
  func getList(
    search: String,
    sort: Sort
  ) -> AnyPublisher<[GameItem], Error>
}

final class GameListInteractor: GameListUseCase {
  private let gameRepository: GameRepositoryProtocol
  
  init(gameRepository: GameRepositoryProtocol) {
    self.gameRepository = gameRepository
  }
  
  func getList(
    search: String,
    sort: Sort
  ) -> AnyPublisher<[GameItem], Error> {
    gameRepository.getList(
      search: search,
      sort: sort
    )
  }
  
}
