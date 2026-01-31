//
//  GameDetailResponse.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

struct GameDetailResponse: Codable, Sendable {
  let id: Int
  let name: String?
  let backgroundImage: String?
  let released: String?
  let rating: Float?
  let genres: [GenreResponse]?
  let description: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case backgroundImage = "background_image"
    case rating
    case released
    case genres
    case description = "description_raw"
  }
}

struct GenreResponse: Codable, Sendable {
  let id: Int
  let name: String
}
