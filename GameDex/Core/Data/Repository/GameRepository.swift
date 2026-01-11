//
//  GameRepository.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 10/01/26.
//

import Combine
import CoreData

protocol GameRepositoryProtocol {
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

final class GameRepository: GameRepositoryProtocol {
  private let remoteDataSource: GameRemoteDataSourceProtocol
  private let gameDao: GameDao
  
  init(
    gameDao: GameDao,
    remoteDataSource: GameRemoteDataSourceProtocol
  ) {
    self.gameDao = gameDao
    self.remoteDataSource = remoteDataSource
  }
  
  func getList(
    search: String,
    sort: Sort
  ) -> AnyPublisher<[GameItem], Error> {
    remoteDataSource.getGameList(
      search: search,
      sort: sort
    )
    .map { $0.toDomain() }
    .eraseToAnyPublisher()
  }
  
  func getDetail(id: Int) -> AnyPublisher<GameDetail, Error> {
    remoteDataSource.getGameDetail(id: id)
      .map { $0.toDomain() }
      .eraseToAnyPublisher()
  }
  
  func getFavoriteGames() -> AnyPublisher<[GameItem], Error> {
    gameDao.getGameList()
      .map { $0.map { $0.toModel() } }
      .eraseToAnyPublisher()
  }
  
  func isFavorite(id: Int) -> AnyPublisher<Bool, Never> {
    gameDao.getGame(id: id)
      .replaceError(with: nil)
      .flatMap { game in
        return Just(game != nil)
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
  
  func updateFavorite(game: GameDetail) -> AnyPublisher<Bool, Error> {
    gameDao.getGame(id: game.id)
      .replaceError(with: nil)
      .flatMap { localGame in
        if localGame != nil {
          return self.gameDao.deleteGame(id: game.id)
            .eraseToAnyPublisher()
        } else {
          return self.gameDao.addGame(game: game)
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }
  
  func removeFavorite(id: Int) -> AnyPublisher<Bool, Error> {
    gameDao.deleteGame(id: id)
      .eraseToAnyPublisher()
  }
}
