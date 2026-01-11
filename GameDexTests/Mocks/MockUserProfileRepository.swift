//
//  MockUserProfileRepository.swift
//  GameDexTests
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import Foundation
@testable import GameDex

class MockUserProfileRepository: UserProfileRepositoryProtocol {
  var stubbedName: String = "fauzan"
  var stubbedDescription: String = "iOS Development Enthusiast"
  
  var getUserNameWasCalled = false
  var getUserDescriptionWasCalled = false
  var setUserNameWasCalled = false
  var setUserDescriptionWasCalled = false
  
  func getUserName() -> String {
    getUserNameWasCalled = true
    return stubbedName
  }
  
  func getUserDescription() -> String {
    getUserDescriptionWasCalled = true
    return stubbedDescription
  }
  
  func setUserName(with name: String) {
    setUserNameWasCalled = true
    stubbedName = name
  }
  
  func setUserDescription(with description: String) {
    setUserDescriptionWasCalled = true
    stubbedDescription = description
  }
}
