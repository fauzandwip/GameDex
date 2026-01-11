//
//  Injection.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 10/01/26.
//

import FactoryKit

extension Container {
  
  var apiService: Factory<APIServiceProtocol> {
    self { APIService() }
  }
  
// MARK: - game
  
  var gameDao: Factory<GameDao> {
    self { CoreDataGameDao() }
  }
  
  var gameRemoteDataSource: Factory<GameRemoteDataSourceProtocol> {
    self { GameRemoteDataSource(service: self.apiService()) }
  }
  
  var gameRepository: Factory<GameRepositoryProtocol> {
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
  
// MARK: - favorite game
  
  var favoriteListUseCase: Factory<FavoriteListUseCase> {
    self { FavoriteListInteractor(gameRepository: self.gameRepository()) }
  }
  
  var favoriteListViewModel: Factory<FavoriteListViewModel> {
    self { FavoriteListViewModel() }
  }
  
// MARK: - user profile
  
  var userProfileLocalDataSource: Factory<UserProfileLocalDataSource> {
    self { UserDefaultsProfile() }
  }
  
  var userProfileRepository: Factory<UserProfileRepositoryProtocol> {
    self { UserProfileRepository(localDataSource: self.userProfileLocalDataSource()) }
  }
  
  var profileUseCase: Factory<ProfileUseCase> {
    self { ProfileInteractor(profileRepository: self.userProfileRepository()) }
  }
  
  var profileViewModel: Factory<ProfileViewModel> {
    self { ProfileViewModel(useCase: self.profileUseCase()) }
  }
}
