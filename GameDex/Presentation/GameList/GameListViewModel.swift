//
//  GameListViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation
import Combine
import FactoryKit

class GameListViewModel: ObservableObject {
  
  @Injected(\.gameListUseCase)
  private var useCase: GameListUseCase
  
  @Published private(set) var gameList = [GameItem]()
  @Published private(set) var isLoading = false
  @Published private(set) var errorMessage: String?
  
  /// search
  @Published var search: String = ""
  @Published var sort: Sort = .latest
  
  private var fetchCancellable: AnyCancellable?
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    setupReactive()
    getList()
  }
  
  func refresh() {
    getList(search: search, sort: sort)
  }
  
  func getList(
    search: String = "",
    sort: Sort = .latest
  ) {
    fetchCancellable?.cancel()
    
    fetchCancellable = useCase.getList(search: search, sort: sort)
      .receive(on: DispatchQueue.main)
      .handleEvents(
        receiveSubscription: { [weak self] _ in
          DispatchQueue.main.async {
            self?.errorMessage = nil
            self?.isLoading = true
          }
        },
        receiveCompletion: { [weak self] _ in self?.isLoading = false },
        receiveCancel: { [weak self] in
          DispatchQueue.main.async {
            self?.isLoading = false }
          }
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
  }
  
  private func setupReactive() {
    Publishers.CombineLatest($search, $sort)
      .map(Query.init)
      .removeDuplicates()
      .dropFirst()
      .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
      .sink { [weak self] query in
        self?.getList(
          search: query.search,
          sort: query.sort
        )
      }
      .store(in: &cancellables)
  }
  
}
