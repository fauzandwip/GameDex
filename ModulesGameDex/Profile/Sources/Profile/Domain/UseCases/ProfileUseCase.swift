//
//  ProfileUseCase.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import Combine

protocol ProfileUseCase {
  func getUserName() -> String
  func getUserDescription() -> String
  func setUserName(with name: String)
  func setUserDescription(with description: String)
}

final class ProfileInteractor: ProfileUseCase {
  private let profileRepository: UserProfileRepositoryProtocol
  
  init(profileRepository: UserProfileRepositoryProtocol) {
    self.profileRepository = profileRepository
  }
  
  func getUserName() -> String {
    profileRepository.getUserName()
  }
  
  func getUserDescription() -> String {
    profileRepository.getUserDescription()
  }
  
  func setUserName(with name: String) {
    profileRepository.setUserName(with: name)
  }
  
  func setUserDescription(with description: String) {
    profileRepository.setUserDescription(with: description)
  }
  
}
