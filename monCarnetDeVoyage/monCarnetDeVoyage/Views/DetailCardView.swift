//
//  DetailCardView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

import SwiftUI

struct DetailCardView: View {

    // injecte une card de type Card
    var card: Lieu
    
    @State private var selection : Bool = false

    var body: some View {

        ScrollView {

            // Vstack principal
            VStack(spacing: 24) {

                // Image
                ZStack(alignment: .topTrailing) {

                    Image(card.photo)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 320)
                        .frame(maxWidth: .infinity)
                        .clipped()

                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 50, height: 50)
                        .overlay {

                            Button {
                                selection.toggle()
                            } label : {
                                Image(systemName: selection ? "heart.fill" : "heart")
                                    .font(.headline)
                            } .foregroundColor(Color.roseSoleil)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .padding()
                        }
                        .padding()
                }
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 36
                    )
                )
                .padding(.horizontal)

                // Vstack ville + pays + description
                VStack(alignment: .leading, spacing: 16) {

                    HStack {

                        // ville + modifier
                        Text(card.ville)
                            .font(.system(size: 34))
                            .fontWeight(.bold)
                            .foregroundColor(Color.roseSoleil)

                        Spacer()

                        NavigationLink {
            
                            ModifierCardView()

                        } label: {

                            Image(systemName: "square.and.pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(Color.roseSoleil)
                        }
                    }

                    // pays + pin
                    HStack {


                            Text(card.pays)
                                .font(.title3)
                                .foregroundStyle(.gray)

                            Image(systemName: "location.fill")
                            .foregroundColor(Color.gray)

                        Spacer()

                        // Hstack note
                        HStack(spacing: 3) {

                            ForEach(0..<5) { i in

                                Image(
                                    systemName:
                                        i < card.note
                                        ? "star.fill"
                                        : "star"
                                )
                                .foregroundColor(.yellow)
                            }
                        }
                    }

                    // séprateur
                    Divider()

                    // a propose
                    Text("À propos")
                        .font(.headline)

                    // description
                    Text(card.description)
                        .font(.body)
                        .foregroundColor(.gray)
                        .lineSpacing(6)

                    VStack(alignment: .leading, spacing: 12) {

                        // Localisation
                        Text("Localisation")
                            .font(.headline)

                        // MAP --> a faire
                        Image("map")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 260)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 24
                                )
                            )
                    }

                    Spacer()
                }
                .padding()
                .background(.white)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 30
                    )
                )
                .shadow(
                    color: .black.opacity(0.05),
                    radius: 12,
                    y: 5
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.beigeClair)
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {

    // je passe les données à la vue de la card index 0
    NavigationStack {

        DetailCardView(
            card: Lieu.cardTest[0]
        )
        
    }
}
