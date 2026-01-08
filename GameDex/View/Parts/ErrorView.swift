//
//  ErrorView.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import SwiftUI

struct ErrorView: View {
    var message: String
    
    var body: some View {
        VStack {
            Text("Error")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text(message)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView(message: "Error URL")
}
