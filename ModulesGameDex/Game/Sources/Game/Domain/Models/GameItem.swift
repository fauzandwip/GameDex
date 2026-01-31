//
//  GameItem.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Core

public struct GameItem: Identifiable {
  public let id: Int
  public let name: String?
  public let imageURL: String?
  public let rating: Float?
  public let released: String?
  
  public var formattedDate: String {
    return (self.released ?? "").formateToStringDate(
      inputFormat: "yyyy-MM-dd",
      outputFormat: "dd MMM yyyy"
    )
  }
  
  public init(id: Int, name: String?, imageURL: String?, rating: Float?, released: String?) {
    self.id = id
    self.name = name
    self.imageURL = imageURL
    self.rating = rating
    self.released = released
  }
}
