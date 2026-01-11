//
//  GameItemView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import SwiftUI

struct GameItemView: View {
  var game: GameItem
  
  var body: some View {
    HStack(spacing: 20) {
      ImageCustomView(
        url: game.imageURL ?? "",
        width: 100,
        height: 100,
        radius: 20
      )
      
      VStack(alignment: .leading) {
        Text(game.name ?? "Game Name")
          .font(.headline)
          .fontWeight(.bold)
        
        Spacer()
          .frame(maxWidth: .infinity)
        
        HStack(spacing: 20) {
          Text(game.formattedDate)
            .foregroundStyle(.white)
            .font(.caption)
            .italic()
            .padding(4)
            .background {
              RoundedRectangle(cornerRadius: 4)
                .fill(.gray)
                .opacity(0.2)
            }
          HStack(spacing: 2) {
            Image(systemName: "star.fill")
              .foregroundStyle(.yellow)
            Text(String(game.rating ?? 0))
              .font(.subheadline)
          }
        }
      }
      .padding(.vertical, 10)
    }
  }
}
