//
//  FavoriteListViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import Foundation

class FavoriteListViewModel: ObservableObject {
    private var gameDao = GameDao()

    @Published var favorites: [GameItem] = []

    func reload() {
        favorites = getList()
    }

    func getList() -> [GameItem] {
        return gameDao.getListGame().map { $0.toModel() }
    }

    func deleteGame(game: GameItem) {
        _ = gameDao.deleteGame(id: game.id)
        reload()
    }
}
