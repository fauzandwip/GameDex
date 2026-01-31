//
//  GameDao.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import CoreData
import Combine
import Core

protocol GameDao {
  func getGameList() -> AnyPublisher<[GameItemEntity], Error>
  func getGame(id: Int) -> AnyPublisher<GameItemEntity?, Error>
  func addGame(game: GameDetail) -> AnyPublisher<Bool, Error>
  func deleteGame(id: Int) -> AnyPublisher<Bool, Error>
}

final class CoreDataGameDao: GameDao {
  private let context = PersistenceShared.shared.context
  private var cancellables = Set<AnyCancellable>()
  
  func getGameList() -> AnyPublisher<[GameItemEntity], Error> {
    return Future { promise in
      let request = GameItemEntity.fetchRequest()
      
      do {
        let games = try self.context.fetch(request)
        promise(.success(games))
      } catch {
        print("Error fetch game list \(error)")
        promise(.success([]))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func getGame(id: Int) -> AnyPublisher<GameItemEntity?, Error> {
    return Future { promise in
      let request = GameItemEntity.fetchRequest()
      request.predicate = NSPredicate(format: "id == %@", String(id))
      request.fetchLimit = 1
      
      do {
        let games = try self.context.fetch(request)
        promise(.success(games.first))
      } catch {
        print("Error fetch item game \(error)")
        promise(.failure(error))
      }
    }
    .eraseToAnyPublisher()
  }
  
  func addGame(game: GameDetail) -> AnyPublisher<Bool, Error> {
    self.getGame(id: game.id)
      .flatMap { localGame in
        if localGame != nil {
          return Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        
        let gameEntity = GameItemEntity(context: self.context)
        gameEntity.id = Int64(game.id)
        gameEntity.name = game.name
        gameEntity.imageURL = game.backgroundImage
        gameEntity.rating = game.rating ?? 0
        gameEntity.released = game.released
        
        return Just(self.saveContext())
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
  
  func deleteGame(id: Int) -> AnyPublisher<Bool, Error> {
    return self.getGame(id: id)
      .flatMap { localGame in
        guard let localGame else {
          return Just(false)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        
        self.context.delete(localGame)
        return Just(self.saveContext())
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
  
  private func saveContext() -> Bool {
    return context.saveContext()
  }
}
