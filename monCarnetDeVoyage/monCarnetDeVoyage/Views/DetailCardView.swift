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
    
    var body: some View {
            
        // Vstack principal
        VStack {
                
        
            // Image
            Image(card.photo)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(maxHeight : 300)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .ignoresSafeArea()
                .padding(.bottom, -55)
            
            
            // Vstack ville + pays + description
            VStack (alignment: .leading, spacing: 6) {
                
                HStack {
                    
                    // ville + modifier
                    Text(card.ville)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(Color(.cyan))
                    
                    Spacer()
                    
                    Button {
                        // Vue
                    } label : {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .font(.title)
                            .foregroundStyle(.pink).opacity(0.6)
                        
                    }
                }

               
                
                
                // pays + pin
                HStack {
                    
                    Text(card.pays)
                        .font(.title)
                        .foregroundStyle(Color(.cyan))
                    
                    Image(systemName: "pin.fill")
                        .font(.callout)
                        .foregroundStyle(.pink).opacity(0.6)
                    
                    Spacer()
                    
                    // Hstack note
                    HStack(spacing: 2) {
                        
                        ForEach(0..<5) { i in
    
                            Image(systemName: i < card.note ? "star.fill" : "star")
                                .foregroundStyle(.yellow)
                                .font(.caption2)
                        }
                    }
                    
                }
               
                
                Text(card.description)
                    .italic()
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                
                
                HStack {
                    
                    if card.visite == true {
                        Text("Statut : Visité")
                    } else {
                        Text("Statut : À visiter")
                    }
                }
                
                ZStack {
                               RoundedRectangle(cornerRadius: 16)
                        .fill(.cyan)
                               
                               Text(card.ville)
                                   .font(.title)
                                   .foregroundColor(.white)
                           }
                
                
                Spacer()
                
            } .padding(.horizontal)
                
            
            
            
           
        }
    }
}

#Preview {
    // je passe les données à la vue de la card index 0
    DetailCardView(card : Lieu.cardTest[0])
}
