//
//  GameItem.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

struct GameItem: Identifiable {
    let id: Int
    let name: String?
    let imageURL: String?
    let rating: Float?
    let released: String?
    
    var formattedDate: String {
      return (self.released ?? "").formateToStringDate(
            inputFormat: "yyyy-MM-dd",
            outputFormat: "dd MMM yyyy"
        )
    }
}
