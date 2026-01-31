//
//  UserProfileRepository.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import Combine

final class UserProfileRepository: UserProfileRepositoryProtocol {
  private let localDataSource: UserProfileLocalDataSource
  
  init(localDataSource: UserProfileLocalDataSource) {
    self.localDataSource = localDataSource
  }
  
  func getUserName() -> String {
    localDataSource.getName()
  }
  
  func getUserDescription() -> String {
    localDataSource.getDescription()
  }
  
  func setUserName(with name: String) {
    localDataSource.setName(with: name)
  }
  
  func setUserDescription(with description: String) {
    localDataSource.setDescription(with: description)
  }
  
}
