//
//  UserDefaultsProfile.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import Foundation
import Combine

protocol UserProfileLocalDataSource {
  func getName() -> String
  func getDescription() -> String
  func setName(with name: String)
  func setDescription(with description: String)
}

final class UserDefaultsProfile: UserProfileLocalDataSource {
  
  func getName() -> String {
    UserDefaults.standard.string(forKey: "name") ?? "Fauzan Dwi Prasetyo"
  }
  
  func getDescription() -> String {
    UserDefaults.standard.string(forKey: "description") ?? "iOS Development Enthusiast"
  }
  
  func setName(with name: String) {
    UserDefaults.standard.set(name, forKey: UserProfileKey.name.rawValue)
  }
  
  func setDescription(with description: String) {
    UserDefaults.standard.set(description, forKey: UserProfileKey.description.rawValue)
  }
  
}
