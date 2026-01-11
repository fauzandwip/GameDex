//
//  CustomTextFieldView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import SwiftUI

struct CustomTextFieldView: View {
  var title: String
  
  @Binding var value: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("\(title) :")
        .font(.headline)
        .fontWeight(.bold)
      
      TextField(title, text: $value)
        .padding(8)
        .background(Color.white.opacity(0.3))
        .cornerRadius(6)
    }
  }
}

#Preview {
  CustomTextFieldView(title: "Name", value: .constant("fauzan"))
}
