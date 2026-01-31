//
//  ProfileUseCaseTests.swift
//  GameDexTests
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import XCTest
import Factory

@testable import Profile

final class ProfileUseCaseTests: XCTestCase {
  private var mockUserProfileRepository: MockUserProfileRepository!
  private var usecase: ProfileUseCase!

  override func setUp() {
    super.setUp()
    Container.shared.reset()

    mockUserProfileRepository = MockUserProfileRepository()
    Container.shared.userProfileRepository.register { self.mockUserProfileRepository }
    
    usecase = Container.shared.profileUseCase()
  }
  
  override func tearDown() {
    mockUserProfileRepository = nil
    usecase = nil
    super.tearDown()
  }
  
  func test_getUserName_success_shouldReturnUserName() {
    let userName = "jack"
    mockUserProfileRepository.stubbedName = userName
    
    let result = usecase.getUserName()
    
    XCTAssertTrue(mockUserProfileRepository.getUserNameWasCalled)
    XCTAssertEqual(mockUserProfileRepository.stubbedName, result)
  }
  
  func test_getUserDescription_success_shouldReturnUserDescription() {
    let userDescription = "I'm Jack"
    mockUserProfileRepository.stubbedDescription = userDescription
    
    let result = usecase.getUserDescription()
    
    XCTAssertTrue(mockUserProfileRepository.getUserDescriptionWasCalled)
    XCTAssertEqual(mockUserProfileRepository.stubbedDescription, result)
  }
  
  func test_setUserName_success_shouldCallSetUserName() {
    let userName = "jack"
    
    usecase.setUserName(with: userName)
    
    XCTAssertTrue(mockUserProfileRepository.setUserNameWasCalled)
    XCTAssertEqual(mockUserProfileRepository.stubbedName, userName)
  }
  
  func test_setUserDescription_success_shouldCallSetUserDescription() {
    let userDescription = "I'm Jack"
    
    usecase.setUserDescription(with: userDescription)
    
    XCTAssertTrue(mockUserProfileRepository.setUserDescriptionWasCalled)
    XCTAssertEqual(mockUserProfileRepository.stubbedDescription, userDescription)
  }
  
}
