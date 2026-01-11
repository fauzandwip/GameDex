//
//  Date.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation

extension String {
  func formateToStringDate(
    inputFormat: String,
    outputFormat: String
  ) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputFormat

    if let date = inputFormatter.date(from: self) {
      let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = outputFormat
      return outputFormatter.string(from: date)
    }

    return "Invalid date"
  }
}


/// TODO:
/// 1. restructure folder √
/// 2. add DI using Factory √
/// 3. implement clean architecture (usecase) √
/// 4. implement reactive for viewmodel (state, etc)
