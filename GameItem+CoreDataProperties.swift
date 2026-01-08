//
//  GameItem+CoreDataProperties.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//
//

import Foundation
import CoreData

extension GameItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameItem> {
        return NSFetchRequest<GameItem>(entityName: "GameItem")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var rating: Float
    @NSManaged public var released: String?

}

extension GameItem: Identifiable {

}
