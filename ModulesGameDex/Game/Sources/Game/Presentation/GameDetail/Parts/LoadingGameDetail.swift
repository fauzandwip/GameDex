//
//  LoadingGameDetail.swift
//  GameDex
//
//  Created by Fauzan Dwi Prasetyo on 20/07/25.
//

import SwiftUI

struct LoadingGameDetail: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
            }

            VStack(alignment: .leading, spacing: 10) {
                RoundedRectangle(cornerRadius: 14)
                    .frame(width: 100, height: 16)

                RoundedRectangle(cornerRadius: 14)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
            }
            .padding(20)
        }
        .foregroundStyle(.gray.opacity(0.3))
    }
}

#Preview {
    LoadingGameDetail()
}
