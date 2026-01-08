//
//  GameDetailViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation
import Combine

class GameDetailViewModel: ObservableObject {
    @Published var gameDetail: GameDetail?
    
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage: String?
    @Published var isFavorite = false
    
    private var service: GameService
    private var cancellables = Set<AnyCancellable>()
    private var gameDao: GameDao
    
    init(id: Int) {
        service = GameService(service: APIService())
        gameDao = GameDao()

        Task {
            getDetail(id: id)
        }
    }
    
    func reload(id: Int) {
        setIsFavorite(id: id)
    }
    
    func getDetail(id: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
        
        service.getGameDetail(id: String(id))
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
                
                self?.isLoading = false
            } receiveValue: { [weak self] detail in
                self?.gameDetail = detail
            }
            .store(in: &cancellables)

    }
    
    func updateFavorite() {
        guard let game = gameDetail else { return }
        
      let _ = isFavorite
      ? gameDao.deleteGame(id: game.id)
      : gameDao.addGame(game: game)
        
        isFavorite.toggle()
    }
    
    func setIsFavorite(id: Int) {
        isFavorite = gameDao.getGame(id: id) != nil
    }
}
