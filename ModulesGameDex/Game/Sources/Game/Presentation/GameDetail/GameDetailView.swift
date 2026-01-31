//
//  GameDetailView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import SwiftUI
import Kingfisher
import Factory
import DesignSystem
import Core

public struct GameDetailView: View {
  @StateObject private var viewModel: GameDetailViewModel
  var gameId: Int
  
  public init(gameId: Int) {
    self.gameId = gameId
    self._viewModel = StateObject(wrappedValue: Container.shared.gameDetailViewModel(gameId))
  }
  
  public var body: some View {
    VStack {
      if viewModel.isLoading {
        LoadingGameDetail()
      } else if let errorMessage = viewModel.errorMessage {
        ErrorView(message: errorMessage)
      } else if let gameDetail = viewModel.gameDetail {
        mainContent(detail: gameDetail)
      }
    }
    .background(.black)
    .foregroundStyle(.white)
    .toolbar {
      ToolbarItem {
        Button {
          viewModel.updateFavorite()
        } label: {
          Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
        }
        .disabled(viewModel.isLoading)
      }
    }
    .task(id: gameId) {
      viewModel.getIsFavorite(id: gameId)
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
          
          Text(detail.name ?? "game_name".localized(bundle: .module))
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
        }.padding(.bottom, 30)
          .padding(.horizontal, 20)
      }.foregroundStyle(.white)
      
      VStack(spacing: 20) {
        /// description
        VStack(alignment: .leading, spacing: 10) {
          Text("about_game".localized(bundle: .module))
            .font(.headline)
            .fontWeight(.bold)
          
          Text(detail.description ?? "")
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        /// information
        VStack(alignment: .leading, spacing: 4) {
          Text("released_date".localized(bundle: .module))
            .font(.subheadline)
            .foregroundStyle(.gray)
          Text(detail.formattedDate)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
    }
  }
  
  private func getGenres(genres: [Genre]) -> String {
    return genres.compactMap { $0.name }.joined(separator: " | ")
  }
}

#Preview {
  GameDetailView(gameId: 5679)
}
