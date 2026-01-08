//
//  ProfileView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 21/07/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    
    var body: some View {
        VStack {
            Image(.profile)
                .resizable()
                .frame(width: 250, height: 250)
                .clipShape(.circle)
                .padding(.bottom, 20)
            
            Text(vm.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 4)
            
            Text(vm.description)
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
                    vm.showSheet.toggle()
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .sheet(isPresented: $vm.showSheet) {
            formSheet()
        }
    }
    
    private func formSheet() -> some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name :")
                        .font(.headline)
                        .fontWeight(.bold)
                    TextField("Name", text: $vm.name)
                        .padding(8)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(6)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description :")
                        .font(.headline)
                        .fontWeight(.bold)
                    TextField("Description", text: $vm.description)
                        .padding(8)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(6)
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.top, 20)
            .background(Color.black)
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        vm.showSheet.toggle()
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
