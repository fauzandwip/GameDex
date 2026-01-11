//
//  MainView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import SwiftUI

struct MainView: View {
  
  init() {
    UITabBar.appearance().backgroundColor = UIColor.black
    UITabBar.appearance().barTintColor = UIColor.black
    UITabBar.appearance().unselectedItemTintColor = UIColor.gray
  }
  
  var body: some View {
    NavigationView {
      TabView {
        Tab("Games", systemImage: "gamecontroller") {
          GameListView()
        }
        
        Tab("Favorites", systemImage: "heart") {
          FavoriteListView()
        }
      }
    }
  }
}

#Preview {
  MainView()
}
