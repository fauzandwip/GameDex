//
//  GameDetail.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

public struct GameDetail {
  public let id: Int
  public let name: String?
  public let backgroundImage: String?
  public let released: String?
  public let rating: Float?
  public let genres: [Genre]?
  public let description: String?
  
  public var formattedDate: String {
    return (self.released ?? "").formateToStringDate(
      inputFormat: "yyyy-MM-dd",
      outputFormat: "dd MMM yyyy"
    )
  }
  
  public init(id: Int, name: String?, backgroundImage: String?, released: String?, rating: Float?, genres: [Genre]?, description: String?) {
    self.id = id
    self.name = name
    self.backgroundImage = backgroundImage
    self.released = released
    self.rating = rating
    self.genres = genres
    self.description = description
  }
}

public struct Genre: Identifiable {
  public let id: Int
  public let name: String
  
  public init(id: Int, name: String) {
    self.id = id
    self.name = name
  }
}
