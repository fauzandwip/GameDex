//
//  CustomTextFieldView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 11/01/26.
//

import SwiftUI
import Core

struct CustomTextFieldView: View {
  var labelKey: String
  
  @Binding var value: String
  
  init(labelKey: String, value: Binding<String>) {
    self.labelKey = labelKey
    self._value = value
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(labelKey.localized(bundle: .module))
        .font(.headline)
        .fontWeight(.bold)
      
      TextField(labelKey, text: $value)
        .padding(8)
        .background(Color.white.opacity(0.3))
        .cornerRadius(6)
    }
  }
}

#Preview {
  CustomTextFieldView(labelKey: "field", value: .constant("fauzan"))
}


