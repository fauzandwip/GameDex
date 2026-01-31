//
//  File.swift
//  Favorite
//
//  Created by Fauzan Dwi Prasetyo on 30/01/26.
//

import Factory
import Core
import Game

extension Container {
  
  var favoriteListUseCase: Factory<FavoriteListUseCase> {
    self { FavoriteListInteractor(gameRepository: self.gameRepository()) }
  }
  
  var favoriteListViewModel: Factory<FavoriteListViewModel> {
    self { FavoriteListViewModel() }
  }
  
}
