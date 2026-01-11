//
//  GameItemEntity+CoreDataProperties.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//
//

import Foundation
import CoreData

extension GameItemEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<GameItemEntity> {
    return NSFetchRequest<GameItemEntity>(entityName: "GameItemEntity")
  }
  
  @NSManaged public var id: Int64
  @NSManaged public var name: String?
  @NSManaged public var imageURL: String?
  @NSManaged public var rating: Float
  @NSManaged public var released: String?
  
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
