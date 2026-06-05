//
//  LieuView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

//
//  CardView.swift
//  monCarnetDeVoyage
//

import SwiftUI

struct CardView: View {

    // carte injectée depuis l'extérieur (données de card)
    var lieu: Lieu
    
    @State private var selection : Bool = false

    var body: some View {

        VStack(spacing: 0) {

            ZStack(alignment: .topTrailing) {

                // image
                Image(lieu.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .frame(maxWidth: .infinity)
                    .clipped()

                // button favoris
                Button {
                    selection.toggle()
                } label: {
                    Image(systemName: selection ? "heart.fill" : "heart")
                        .font(.headline)
                }
                    .foregroundColor(Color.roseSoleil)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .padding()
            }

            
            // bas de la carte
            VStack(alignment: .leading, spacing: 12) {

                HStack(alignment: .top) {

                    VStack(alignment: .leading, spacing: 4) {

                        // ville
                        Text(lieu.ville)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.roseSoleil)

                            // pays
                            Text(lieu.pays)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        
                    }

                    Spacer()

                    // Note
                    HStack(spacing: 2) {

                        ForEach(0..<5) { i in

                            Image(
                                systemName:
                                    i < lieu.note
                                    ? "star.fill"
                                    : "star"
                            )
                            .foregroundColor(.yellow)
                            .font(.caption)
                        }
                    }
                }

                // description
                Text(lieu.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)

                HStack {

                    // Découvrir
                    Text("Découvrir")
                        .fontWeight(.semibold)

                    Image(systemName: "arrow.right")
                }
                .foregroundColor(Color.bleuLagon)
            }
            .padding()
            .background(.white)
        }
        .clipShape(
            RoundedRectangle(
                cornerRadius: 28
            )
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 12,
            y: 6
        )
        .padding(.horizontal)
    }
}

#Preview {
    CardView(
        lieu: Lieu.cardTest[0]
    )
}
