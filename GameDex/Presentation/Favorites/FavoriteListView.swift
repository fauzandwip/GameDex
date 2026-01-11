//
//  FavoriteListView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import SwiftUI
import FactoryKit

struct FavoriteListView: View {
  @InjectedObject(\.favoriteListViewModel)
  var viewModel: FavoriteListViewModel
  
  private let columns = [
    GridItem(.adaptive(minimum: 150, maximum: 150))
  ]
  
  var body: some View {
    NavigationView {
      VStack {
        if viewModel.favorites.isEmpty {
          Text("Your favorites list is empty.")
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
          mainContent
        }
      }
      .background(Color.black)
      .foregroundStyle(.white)
      .navigationTitle("Favorites")
      .onAppear {
        viewModel.getFavorites()
      }
    }
  }
  
  private var mainContent: some View {
    ScrollView(showsIndicators: false) {
      LazyVGrid(columns: columns, spacing: 20) {
        ForEach(viewModel.favorites) { item in
          NavigationLink {
            GameDetailView(gameId: item.id)
          } label: {
            FavoriteCardView(game: item, onClickUnFavorite: viewModel.deleteGame)
          }
        }
      }
    }
  }
}

#Preview {
  FavoriteListView()
}
