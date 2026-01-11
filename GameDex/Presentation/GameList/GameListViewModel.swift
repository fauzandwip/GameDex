//
//  GameListViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation
import Combine
import FactoryKit

enum Sort: String, CaseIterable, Identifiable {
  case latest, oldest
  var id: String { self.rawValue }
}

class GameListViewModel: ObservableObject {
  
  @Injected(\.gameListUseCase)
  private var useCase: GameListUseCase
  
  @Published var gameList = [GameItem]()
  @Published var isLoading = false
  @Published var errorMessage: String?
  
  /// search
  @Published var search: String = ""
  @Published var sort: Sort = .latest
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    Task {
      getList()
    }
  }
  
  func getList(
    search: String = "",
    sort: Sort = .latest
  ) {
    useCase.getList(search: search, sort: sort)
      .receive(on: DispatchQueue.main)
      .handleEvents(
        receiveSubscription: { [weak self] _ in
          DispatchQueue.main.async {
            self?.isLoading = true
          }
        },
        receiveCompletion: { [weak self] _ in self?.isLoading = false }
      )
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.errorMessage = nil
        case .failure(let error):
          self?.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] games in
        self?.gameList = games
      }
      .store(in: &cancellables)

  }
  
  func onSearch(keyword: String) {
    if errorMessage == nil {
      getList(search: keyword)
    }
  }
  
  func onSort(sort: Sort) {
    if errorMessage == nil {
      getList(sort: sort)
    }
  }
  
}
