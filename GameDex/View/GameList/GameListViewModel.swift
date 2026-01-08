//
//  GameListViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation
import Combine

enum Sort: String, CaseIterable, Identifiable {
    case latest, oldest
    var id: String { self.rawValue }
}

class GameListViewModel: ObservableObject {
    @Published var gameList = [GameItem]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    /// search
    @Published var search: String = ""
    @Published var sort: Sort = .latest
    
    private var service: GameService
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        service = GameService(service: APIService())
        
        Task {
            getList()
        }
    }
    
    func getList(
        search: String = "",
        sort: Sort = .latest
    ) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }

        service.getGameList(search: search, sort: sort)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
                
                if case .finished = completion {
                    self?.errorMessage = nil
                }
                
                self?.isLoading = false
            } receiveValue: { [weak self] list in
                self?.gameList = list
            }
            .store(in: &self.cancellable)
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
