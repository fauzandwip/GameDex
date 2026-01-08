//
//  GameDetail.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

struct GameDetail {
    let id: Int
    let name: String?
    let backgroundImage: String?
    let released: String?
    let rating: Float?
    let genres: [Genre]?
    let description: String?

    var formattedDate: String {
      return (self.released ?? "").formateToStringDate(
            inputFormat: "yyyy-MM-dd",
            outputFormat: "dd MMM yyyy"
        )
    }
}

struct Genre: Identifiable {
    let id: Int
    let name: String
}
