//
//  FormSheetView.swift
//  Profile
//
//  Created by Fauzan Dwi Prasetyo on 31/01/26.
//

import SwiftUI
import Core

struct FormSheetView: View {
  @EnvironmentObject var viewModel: ProfileViewModel
  
  let onSubmit: () -> Void
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        CustomTextFieldView(labelKey: "form_label_name", value: $viewModel.name)
        CustomTextFieldView(labelKey: "form_label_description", value: $viewModel.description)
        Spacer()
      }
      .foregroundStyle(.white)
      .padding(.top, 20)
      .background(Color.black)
      .navigationTitle("sheet_title".localized(bundle: .module))
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          Button("sheet_submit".localized(bundle: .module)) {
            onSubmit()
            viewModel.onSubmit()
          }
        }
      }
    }
    .background(Color.black.ignoresSafeArea(.all))
  }
}

#Preview {
  FormSheetView(onSubmit: {})
}
