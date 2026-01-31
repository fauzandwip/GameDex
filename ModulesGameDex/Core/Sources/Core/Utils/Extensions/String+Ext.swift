//
//  Date.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation

public extension String {
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

public extension String {
    func localized(bundle: Bundle) -> String {
        NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
