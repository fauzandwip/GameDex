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
  
  @Published var showSheet = false
  
  @Published var name: String {
    didSet {
      setName(with: name)
    }
  }
  
  @Published var description: String {
    didSet {
      setDescription(with: description)
    }
  }
  
  init(useCase: ProfileUseCase) {
    self.useCase = useCase
    name = useCase.getUserName()
    description = useCase.getUserDescription()
  }
  
  func setup() {
    getName()
    getDescription()
  }
  
  func getName() {
    name = useCase.getUserName()
  }
  
  func getDescription() {
    description = useCase.getUserDescription()
  }
  
  func setName(with name: String) {
    useCase.setUserName(with: name)
  }
  
  func setDescription(with description: String) {
    useCase.setUserDescription(with: description)
  }
  
}
