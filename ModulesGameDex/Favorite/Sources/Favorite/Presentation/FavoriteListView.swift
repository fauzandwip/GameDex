//
//  FavoriteListView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 27/07/25.
//

import SwiftUI
import Factory
import Core

public struct FavoriteListView<Detail: View>: View {
  @InjectedObject(\.favoriteListViewModel)
  private var viewModel: FavoriteListViewModel
  
  @ViewBuilder let detailView: (_ id: Int) -> Detail
  
  public init(
    detailView: @escaping (_: Int) -> Detail
  ) {
    self.detailView = detailView
  }
  
  private let columns = [
    GridItem(.adaptive(minimum: 150, maximum: 150))
  ]
  
  public var body: some View {
    NavigationView {
      VStack {
        if viewModel.favorites.isEmpty {
          Text("empty_list".localized(bundle: .module))
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
          mainContent
        }
      }
      .background(Color.black)
      .foregroundStyle(.white)
      .navigationTitle("nav_title".localized(bundle: .module))
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
            detailView(item.id)
          } label: {
            FavoriteCardView(game: item, onClickUnFavorite: viewModel.deleteGame)
          }
        }
      }
    }
  }
}
