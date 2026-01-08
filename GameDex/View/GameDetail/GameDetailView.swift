//
//  GameDetailView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import SwiftUI
import Kingfisher

struct GameDetailView: View {
    @StateObject private var vm: GameDetailViewModel
    var gameId: Int
    
    init(gameId: Int) {
        self.gameId = gameId
        self._vm = StateObject(wrappedValue: GameDetailViewModel(id: gameId))
    }
    
    var body: some View {
        VStack {
            if vm.isLoading {
                LoadingGameDetail()
            } else if let errorMessage = vm.errorMessage {
                ErrorView(message: errorMessage)
            } else {
                if let gameDetail = vm.gameDetail {
                    mainContent(detail: gameDetail)
                }
            }
        }
        .background(.black)
        .foregroundStyle(.white)
        .toolbar {
            ToolbarItem {
                Button {
                    vm.updateFavorite()
                } label: {
                    Image(systemName: vm.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
        .onAppear {
            vm.reload(id: gameId)
        }
    }
    
    private func mainContent(detail: GameDetail) -> some View {
        ScrollView(showsIndicators: false) {
            /// header
            ZStack {
                ImageCustomView(
                    url: detail.backgroundImage ?? "",
                    radius: 16
                )
                .clipped()
                .overlay(
                    LinearGradient(
                        colors: [.black, .clear],
                        startPoint: .bottom, endPoint: .top
                    )
                )
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text(detail.name ?? "Game Name")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack {
                        if let genres = detail.genres {
                            Text(getGenres(genres: genres))
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text(String(detail.rating ?? 0))
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.bottom, 30)
                .padding(.horizontal, 20)
            }
            .foregroundStyle(.white)
            
            VStack(spacing: 20) {
                /// description
                VStack(alignment: .leading, spacing: 10) {
                    Text("About Game")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(detail.description ?? "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                /// information
                VStack(alignment: .leading, spacing: 4) {
                    Text("Released date")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text(detail.formattedDate)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        }
    }
    
    private func getGenres(genres: [Genre]) -> String {
        return genres.compactMap { $0.name }.joined(separator: " | ")
    }
}

#Preview {
    GameDetailView(gameId: 5679)
}
