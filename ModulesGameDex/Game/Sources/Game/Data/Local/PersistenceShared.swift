//
//  PersistenceShared.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import CoreData

class PersistenceShared {
  nonisolated(unsafe) static let shared = PersistenceShared()
  
  private init() {}
  
  lazy var persistentContainer: NSPersistentContainer = {
    guard let modelURL = Bundle.module.url(
      forResource: "GameModel",
      withExtension: "momd"
    ) else {
      fatalError("Failed to find GameModel.xcdatamodeld in Bundle.module")
    }

    let model = NSManagedObjectModel(contentsOf: modelURL)!

    let container = NSPersistentContainer(
        name: "GameModel",
        managedObjectModel: model
    )
    
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
}

extension NSManagedObjectContext {
  func saveContext() -> Bool {
    if self.hasChanges {
      do {
        try self.save()
        return true
      } catch {
        print("Save error: \(error)")
        return false
      }
    }
    return true
  }
}
