//
//  File.swift
//  Game
//
//  Created by Fauzan Dwi Prasetyo on 30/01/26.
//

import Factory
import Core

extension Container {
  
  var gameDao: Factory<GameDao> {
    self { CoreDataGameDao() }
  }
  
  var gameRemoteDataSource: Factory<GameRemoteDataSourceProtocol> {
    self { GameRemoteDataSource(service: self.apiService()) }
  }
  
  public var gameRepository: Factory<GameRepositoryProtocol> {
    self { GameRepository(
      gameDao: self.gameDao(),
      remoteDataSource: self.gameRemoteDataSource()
    )}
  }
  
  var gameListUseCase: Factory<GameListUseCase> {
    self { GameListInteractor(gameRepository: self.gameRepository()) }
  }
  
  var gameListViewModel: Factory<GameListViewModel> {
    self { GameListViewModel() }
  }
  
  var gameDetailUseCase: Factory<GameDetailUseCase> {
    self { GameDetailInteractor(gameRepository: self.gameRepository()) }
  }
  
  var gameDetailViewModel: ParameterFactory<Int, GameDetailViewModel> {
    self { GameDetailViewModel(id: $0) }
  }
  
}
