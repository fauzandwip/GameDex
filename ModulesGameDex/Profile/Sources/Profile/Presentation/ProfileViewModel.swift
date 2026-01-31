//
//  ProfileViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import Foundation
import Factory

class ProfileViewModel: ObservableObject {
  
  private var useCase: ProfileUseCase
  
  @Published var name: String
  @Published var description: String
  
  init(useCase: ProfileUseCase) {
    self.useCase = useCase
    self.name = useCase.getUserName()
    self.description = useCase.getUserDescription()
  }
  
  func getName() {
    name = useCase.getUserName()
  }
  
  func getDescription() {
    description = useCase.getUserDescription()
  }
  
  func setName() {
    useCase.setUserName(with: name)
  }
  
  func setDescription() {
    useCase.setUserDescription(with: description)
  }
  
  func onSubmit() {
    setName()
    setDescription()
  }
  
}
