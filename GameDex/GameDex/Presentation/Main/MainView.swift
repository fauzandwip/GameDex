//
//  MainView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import SwiftUI
import Game
import Favorite
import Profile

struct MainView: View {
  
  init() {
    UITabBar.appearance().backgroundColor = UIColor.black
    UITabBar.appearance().barTintColor = UIColor.black
    UITabBar.appearance().unselectedItemTintColor = UIColor.gray
  }
  
  var body: some View {
    NavigationView {
      TabView {
        Tab("games", systemImage: "gamecontroller") {
          GameListView { ProfileView() }
        }
        
        Tab("favorites", systemImage: "heart") {
          FavoriteListView { id in
            GameDetailView(gameId: id)
          }
        }
      }
    }
  }
}

#Preview {
  MainView()
}
