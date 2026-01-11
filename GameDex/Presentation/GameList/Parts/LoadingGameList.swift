//
//  LoadingGameList.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import SwiftUI

struct LoadingGameList: View {
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 25) {
        ForEach(0..<10) { _ in
          HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20)
              .frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
              RoundedRectangle(cornerRadius: 8)
                .frame(width: 200, height: 14)
              
              Spacer()
                .frame(maxWidth: .infinity)
              
              HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 8)
                  .frame(width: 100, height: 14)
                
                RoundedRectangle(cornerRadius: 8)
                  .frame(width: 50, height: 14)
              }
            }
            .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .foregroundStyle(.gray.opacity(0.3))
        }
      }
      .padding(.horizontal, 20)
    }
  }
}

#Preview {
  LoadingGameList()
}
