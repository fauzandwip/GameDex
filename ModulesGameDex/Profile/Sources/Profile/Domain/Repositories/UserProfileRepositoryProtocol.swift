//
//  File.swift
//  Core
//
//  Created by Fauzan Dwi Prasetyo on 30/01/26.
//

protocol UserProfileRepositoryProtocol {
  func getUserName() -> String
  func getUserDescription() -> String
  func setUserName(with name: String)
  func setUserDescription(with description: String)
}
