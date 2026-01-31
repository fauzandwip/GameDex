//
//  GameDetailViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation
import Combine
import Factory

class GameDetailViewModel: ObservableObject {
  
  @Injected(\.gameDetailUseCase)
  private var useCase: GameDetailUseCase
  
  @Published var gameDetail: GameDetail?
  
  @Published var isLoading = false
  @Published var isError = false
  @Published var errorMessage: String?
  @Published var isFavorite = false
  
  private var cancellables = Set<AnyCancellable>()
  
  init(id: Int) {
    getDetail(id: id)
  }
  
  func getIsFavorite(id: Int) {
    setIsFavorite(id: id)
  }
  
  func getDetail(id: Int) {
    useCase.getGame(id: id)
      .receive(on: DispatchQueue.main)
      .handleEvents(
        receiveSubscription: { [weak self] _ in
          self?.isLoading = true
          self?.errorMessage = nil
        },
        receiveCompletion: { [weak self] _ in
          self?.isLoading = false
        },
        receiveCancel: { [weak self] in
          self?.isLoading = false
        }
      )
      .sink { [weak self] completion in
        switch completion {
        case .finished:
          self?.errorMessage = nil
        case .failure(let error):
          self?.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] game in
        self?.gameDetail = game
      }
      .store(in: &cancellables)
  }
  
  func updateFavorite() {
    guard let game = gameDetail else { return }
    
    isFavorite.toggle()
    
    useCase.updateFavorite(game: game)
      .receive(on: DispatchQueue.main)
      .sink { _ in
      } receiveValue: { _ in
      }.store(in: &cancellables)

  }
  
  func setIsFavorite(id: Int) {
    useCase.isFavorite(id: id)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] isFavorite in
        self?.isFavorite = isFavorite
      }
      .store(in: &cancellables)
  }
  
}
