//
//  GameListView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 09/07/25.
//

import SwiftUI
import Kingfisher
import FactoryKit

struct GameListView: View {
  
  @InjectedObject(\.gameListViewModel)
  private var viewModel: GameListViewModel
  
  init() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .black
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
  
  var body: some View {
    NavigationView {
      VStack {
        searchView
        
        if viewModel.isLoading {
          LoadingGameList()
        } else if let errorMessage = viewModel.errorMessage {
          ErrorView(message: errorMessage)
        } else {
          gameListView
        }
      }
      .foregroundStyle(.white)
      .background(.black)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationTitle("GameDex")
      .navigationBarTitleDisplayMode(.automatic)
      .toolbar {
        ToolbarItem {
          NavigationLink {
            ProfileView()
          } label: {
            Image(systemName: "person.fill")
          }
        }
      }
      .refreshable {
        Task {
          viewModel.refresh()
        }
      }
    }
  }

}

extension GameListView {
  
  private var searchView: some View {
    HStack(spacing: 6) {
      TextField(
        "Search",
        text: $viewModel.search,
        prompt: Text("search game ...").foregroundStyle(.gray.opacity(0.5))
      )
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(.white)
      .clipShape(.capsule)
      .foregroundStyle(.black)
      
      sortView
    }
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
  }
  
  private var sortView: some View {
    Picker("Sort", selection: $viewModel.sort) {
      ForEach(Sort.allCases, id: \.self) { sort in
        Text(sort.rawValue.capitalized)
          .tag(sort.rawValue)
      }
    }
  }
  
  private var gameListView: some View {
    ScrollView {
      VStack(spacing: 25) {
        ForEach(viewModel.gameList) { game in
          NavigationLink {
            GameDetailView(gameId: game.id)
          } label: {
            GameItemView(game: game)
          }
        }
      }
      .padding(.horizontal, 20)
    }
  }
  
}

#Preview {
  GameListView()
}
