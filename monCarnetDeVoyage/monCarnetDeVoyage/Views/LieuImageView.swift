//
//  LieuImageView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 07/06/2026.
//

import SwiftUI

struct LieuImageView: View {
    let imageData: Data?

    var body: some View {
        ZStack {
            if let imageData,
               let uiImage = UIImage(data: imageData) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()

            } else {
                Image(systemName: "photo")
                    .font(.system(size: 50))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.bleuLagon, .roseSoleil],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
        }
    }
}

#Preview {
    LieuImageView(imageData: nil)
}
