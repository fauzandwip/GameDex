//
//  ProfileView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 21/07/25.
//

import SwiftUI
import Factory
import Core

public struct ProfileView: View {
  @InjectedObject(\.profileViewModel)
  var viewModel: ProfileViewModel
  
  @State private var showSheet = false
  
  public init() {}
  
  public var body: some View {
    VStack {
      Image(.profile)
        .resizable()
        .frame(width: 250, height: 250)
        .clipShape(.circle)
        .padding(.bottom, 20)
      
      Text(viewModel.name)
        .font(.title)
        .fontWeight(.bold)
        .padding(.bottom, 4)
      
      Text(viewModel.description)
        .font(.headline)
        .italic()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle("nav_title".localized(bundle: .module))
    .background(.black)
    .foregroundStyle(.white)
    .toolbar {
      ToolbarItem {
        Button {
          showSheet.toggle()
        } label: {
          Image(systemName: "pencil")
        }
      }
    }
    .sheet(isPresented: $showSheet) {
      FormSheetView {
        showSheet.toggle()
      }
      .environmentObject(viewModel)
    }
  }
  
}
