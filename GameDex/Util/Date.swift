//
//  Date.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import Foundation

func formateToStringDate(
    stringDate: String,
    inputFormat: String,
    outputFormat: String
) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputFormat
    
    if let date = inputFormatter.date(from: stringDate) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        return outputFormatter.string(from: date)
    }
    
    return ""
}
