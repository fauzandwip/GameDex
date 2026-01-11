//
//  ProfileView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 21/07/25.
//

import SwiftUI
import FactoryKit

struct ProfileView: View {
  @InjectedObject(\.profileViewModel)
  private var viewModel: ProfileViewModel
  
  @State private var showSheet = false
  
  var body: some View {
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
    .navigationTitle("Profile")
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
      formSheet()
    }
  }
  
}

extension ProfileView {
  
  private func formSheet() -> some View {
    NavigationView {
      VStack(spacing: 20) {
        CustomTextFieldView(title: "Name", value: $viewModel.name)
        CustomTextFieldView(title: "Description", value: $viewModel.description)
        Spacer()
      }
      .foregroundStyle(.white)
      .padding(.top, 20)
      .background(Color.black)
      .navigationTitle("Edit Profile")
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("Done") {
            showSheet.toggle()
            viewModel.onSubmit()
          }
        }
      }
    }
    .background(Color.black.ignoresSafeArea(.all))
  }
  
}


#Preview {
  ProfileView()
}
