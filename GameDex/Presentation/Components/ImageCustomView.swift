//
//  ImageCustomView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 21/07/25.
//

import SwiftUI
import Kingfisher

struct ImageCustomView: View {
  @State private var isError = false
  let url: String
  let width: CGFloat?
  let height: CGFloat?
  let radius: CGFloat
  
  init(
    isError: Bool = false,
    url: String,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    radius: CGFloat = 0
  ) {
    self.isError = isError
    self.url = url
    self.width = width
    self.height = height
    self.radius = radius
  }
  
  var body: some View {
    if isError {
      RoundedRectangle(cornerRadius: 12)
        .fill(.gray.opacity(0.3))
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: width ?? .infinity)
        .clipShape(RoundedRectangle(cornerRadius: radius))
        .overlay {
          VStack {
            Image(systemName: "photo")
              .foregroundStyle(.gray)
              .font(.title2)
          }
        }
    } else {
      KFImage(URL(string: url))
        .placeholder {
          RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.3))
            .overlay {
              ProgressView()
            }
        }
        .retry(maxCount: 3, interval: .seconds(2))
        .onSuccess { _ in isError = false }
        .onFailure { _ in isError = true }
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: width, height: height)
        .frame(maxWidth: width ?? .infinity)
        .clipShape(RoundedRectangle(cornerRadius: radius))
    }
  }
}

#Preview {
  ImageCustomView(url: "")
}
