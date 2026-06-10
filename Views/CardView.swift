//
//  LieuView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

import SwiftUI

struct CardView: View {

    var lieu: Lieu

    var body: some View {

        VStack(spacing: 0) {

            LieuImageView(imageData: lieu.photo)
                .scaledToFill()
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .clipped()

            VStack(alignment: .leading, spacing: 12) {

                HStack(alignment: .top) {

                    VStack(alignment: .leading, spacing: 4) {
                        Text(lieu.ville)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.roseSoleil)

                        Text(lieu.pays)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    HStack(spacing: 2) {
                        ForEach(0..<5, id: \.self) { i in
                            Image(systemName: i < lieu.note ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                    }
                }

                Text(lieu.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                HStack {
                    Text("Découvrir")
                        .fontWeight(.semibold)

                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.bleuLagon)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .black.opacity(0.08), radius: 12, y: 6)
    }
}

#Preview {
    CardView(
        lieu: Lieu(
            id: UUID(),
            photo: nil,
            ville: "Paris",
            pays: "France",
            description: "Preview",
            note: 4,
            statut: .aVisiter,
            latitude: 48.8566,
            longitude: 2.3522 
        )
    )
}
