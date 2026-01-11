//
//  ProfileViewModel.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import Foundation
import FactoryKit

class ProfileViewModel: ObservableObject {
  
  private var useCase: ProfileUseCase
  
  @Published var name: String
  @Published var description: String
  
  init(useCase: ProfileUseCase) {
    self.useCase = useCase
    self.name = useCase.getUserName()
    self.description = useCase.getUserDescription()
  }
  
  private func getName() {
    name = useCase.getUserName()
  }
  
  private func getDescription() {
    description = useCase.getUserDescription()
  }
  
  private func setName() {
    useCase.setUserName(with: name)
  }
  
  private func setDescription() {
    useCase.setUserDescription(with: description)
  }
  
  func onSubmit() {
    setName()
    setDescription()
  }
  
}
