//
//  GameMapper.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

extension GameListResponse {
    func toModel() -> [GameItem] {
        return self.results.map { $0.toModel() }
    }
}

extension GameItemResponse {
    func toModel() -> GameItem {
        GameItem(
            id: self.id,
            name: self.name,
            imageURL: self.backgroundImage,
            rating: self.rating,
            released: self.released
        )
    }
}

extension GameDetailResponse {
    func toModel() -> GameDetail {
        GameDetail(
            id: self.id,
            name: self.name,
            backgroundImage: self.backgroundImage,
            released: self.released,
            rating: self.rating,
            genres: self.genres?.map { .init(id: $0.id, name: $0.name) },
            description: self.description
        )
    }
}
