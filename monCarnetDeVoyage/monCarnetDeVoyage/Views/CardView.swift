//
//  LieuView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

import SwiftUI

struct CardView: View {
    
    // carte injecté depuis l'extérieur (données de card)
    var lieu: Lieu
    
    var body: some View {
        
        // image
        Image(lieu.photo)
            .resizable()
            .scaledToFill()
            .frame(height: 220)
            .frame(maxWidth: .infinity)
            .clipped()
            .overlay(alignment: .bottom) {
                
                // Vstack principal opacité
                VStack(alignment: .leading, spacing: 6) {
                    
                    //HStack principal ville + note
                    HStack {
                        
                        // ville
                        Text(lieu.ville)
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                        
                        // Hstack note
                        HStack(spacing: 2) {
                            
                            ForEach(0..<5) { i in
        
                                Image(systemName: i < lieu.note ? "star.fill" : "star")
                                    .foregroundStyle(.yellow)
                                    .font(.caption2)
                            }
                        }
                    }
                    
                    // pays
                    Text(lieu.pays)
                        .font(.headline)
                        .bold()
                    
                    Text(lieu.description)
                        .font(.caption)
                        .lineLimit(2)
                    
                }.padding(10)
                .background(.white.opacity(0.7))
                
            }.cornerRadius(14)
            .shadow(radius: 5)
            .padding()
    }
}

// données de test envoyé à la vue (index0)
#Preview {
        CardView(lieu: Lieu.cardTest[0])
}
