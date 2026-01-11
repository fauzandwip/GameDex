//
//  FavoriteCardView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import SwiftUI

struct FavoriteCardView: View {
  var game: GameItem
  let onClickUnFavorite: (_ id: Int) -> Void
  
  var body: some View {
    VStack {
      ImageCustomView(
        url: game.imageURL ?? "",
        width: 150,
        height: 150,
        radius: 20
      )
      
      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 5) {
          HStack {
            Text(game.name ?? "Game Name")
              .font(.headline)
              .fontWeight(.medium)
              .lineLimit(1)
              .truncationMode(.tail)
            
            Spacer()
            
            favoriteIcon(id: game.id)
          }
          
          Text("\(game.formattedDate)")
            .fontWeight(.bold)
            .font(.headline)
          
          HStack(spacing: 2) {
            Image(systemName: "star.fill")
              .foregroundStyle(.yellow)
            Text(String(game.rating ?? 0))
              .font(.subheadline)
          }
        }
        .frame(maxWidth: .infinity)
      }
      
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .cornerRadius(10)
    .frame(maxWidth: 200)
    .padding(5)
  }
  
  private func favoriteIcon(id: Int) -> some View {
    Button {
      onClickUnFavorite(id)
    } label: {
      Image(systemName: "heart.fill")
        .font(.title3)
        .foregroundStyle(.red)
    }
  }
}
