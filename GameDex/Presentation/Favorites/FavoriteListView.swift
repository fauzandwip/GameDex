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
                viewModel.fetchFavorites()
            }
        }
    }

    var mainContent: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.favorites) { item in
                    NavigationLink {
                        GameDetailView(gameId: item.id)
                    } label: {
                        card(game: item)
                    }
                }
            }
        }
    }

    private func card(game: GameItem) -> some View {
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

                        favoriteIcon(game: game)
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

    private func favoriteIcon(game: GameItem) -> some View {
        Button {
          viewModel.deleteGame(id: game.id)
        } label: {
            Image(systemName: "heart.fill")
                .font(.title3)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    FavoriteListView()
}
