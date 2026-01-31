//
//  GameItemEntity+CoreDataProperties.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//
//

import Foundation
import CoreData
import Core

extension GameItemEntity {
  
  @nonobjc class func fetchRequest() -> NSFetchRequest<GameItemEntity> {
    return NSFetchRequest<GameItemEntity>(entityName: "GameItemEntity")
  }
  
  @NSManaged var id: Int64
  @NSManaged var name: String?
  @NSManaged var imageURL: String?
  @NSManaged var rating: Float
  @NSManaged var released: String?
  
  func toModel() -> GameItem {
    GameItem(
      id: Int(self.id),
      name: self.name,
      imageURL: self.imageURL,
      rating: self.rating,
      released: self.released
    )
  }
  
}

extension GameItemEntity: Identifiable {
  
}
