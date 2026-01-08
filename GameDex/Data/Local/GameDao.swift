//
//  GameDao.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import CoreData

class GameDao {
    private let context = PersistenceShared.shared.context

    func getListGame() -> [GameItemEntity] {
        let request = GameItemEntity.fetchRequest()
        
        do {
            let games = try context.fetch(request)
            return games
        } catch {
            print("Error fetch game list \(error)")
            return []
        }
    }
    
    func getGame(id: Int) -> GameItemEntity? {
        let request = GameItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", String(id))
        request.fetchLimit = 1
        
        do {
            let games = try context.fetch(request)
            return games.first
        } catch {
            print("Error fetch item game \(error)")
            return nil
        }
    }
    
    func addGame(game: GameDetail) -> Bool {
        if let _ = getGame(id: game.id) {
            return true
        }
        
        let gameEntity = GameItemEntity(context: self.context)
        gameEntity.id = Int64(game.id)
        gameEntity.name = game.name
        gameEntity.imageURL = game.backgroundImage
        gameEntity.rating = game.rating ?? 0
        gameEntity.released = game.released
        
        return saveContext()
    }
    
    func deleteGame(id: Int) -> Bool {
        guard let game = getGame(id: id) else {
            print("Game with id \(id) not found")
            return false
        }
        
        context.delete(game)
        return saveContext()
    }
    
    private func saveContext() -> Bool {
        return context.saveContext()
    }
}
