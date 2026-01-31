//
//  File.swift
//  Profile
//
//  Created by Fauzan Dwi Prasetyo on 30/01/26.
//

import Factory

extension Container {
  
  var userProfileLocalDataSource: Factory<UserProfileLocalDataSource> {
    self { UserDefaultsProfile() }
  }
  
  var userProfileRepository: Factory<UserProfileRepositoryProtocol> {
    self { UserProfileRepository(localDataSource: self.userProfileLocalDataSource()) }
  }
  
  var profileUseCase: Factory<ProfileUseCase> {
    self { ProfileInteractor(profileRepository: self.userProfileRepository()) }
  }
  
  var profileViewModel: Factory<ProfileViewModel> {
    self { ProfileViewModel(useCase: self.profileUseCase()) }
  }
  
}
