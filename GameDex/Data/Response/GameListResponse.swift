//
//  GameListResponse.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

struct GameListResponse: Codable {
    let results: [GameItemResponse]
}

struct GameItemResponse: Codable {
    let id: Int
    let name: String?
    let backgroundImage: String?
    let rating: Float?
    let released: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case rating
        case released
    }
}
