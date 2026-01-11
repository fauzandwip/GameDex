//
//  FavoriteListViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import Foundation
import Combine
import FactoryKit

class FavoriteListViewModel: ObservableObject {
  
  @Injected(\.favoriteListUseCase)
  private var useCase: FavoriteListUseCase
  
  @Published var favorites: [GameItem] = []
  
  private var cancellables = Set<AnyCancellable>()
  
  func fetchFavorites() {
    getList()
  }
  
  func getList() {
    useCase.getList()
      .sink { _ in
      } receiveValue: { [weak self] favorites in
        self?.favorites = favorites
      }
      .store(in: &cancellables)

  }
  
  func deleteGame(id: Int) {
    if let index = favorites.firstIndex(where: { $0.id == id }) {
      favorites.remove(at: index)
    }
    
    useCase.deleteGame(id: id)
      .receive(on: DispatchQueue.main)
      .sink { _ in
      } receiveValue: { _ in
      }
      .store(in: &cancellables)
  }
  
}
