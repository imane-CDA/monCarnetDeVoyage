//
//  ContentView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 03/06/2026.
//

import SwiftUI

struct ProfilView: View {
    
    // Utilisateur injecté depuis l'extérieur (données du profil)
    var user: User
    
    var body: some View {
        
        ZStack {
// background bleu
//            Color(.fondBleu)
                
            
            //Scrollview
            ScrollView {
            
                
                // VStack principal
                VStack(spacing: 20) {
                    
                    // Hstack image + pseudo
                    HStack(spacing: 15) {
                        
                        //photo
                        Image(user.photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                .stroke(.white, lineWidth: 3)
                            )
                            .shadow(radius: 5)
                        
                        // pseudo
                        Text(user.pseudo)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 40)
                        
                        Spacer()
                        
                    }.padding()
                    
                    // Titre -> mes lieux visités
                    HStack {
                        
                        Text("Mes lieux visités")
                            .font(.title2)
                            .bold()
                        
                        Image(systemName: "map")
                        
                        Spacer()
                        
                    } .padding(.horizontal)
                    
                    // cartes
                        VStack(spacing: 16) {
                            
                            // ForEach parcours le tableau et affiche les cartes
                            ForEach(Card.cardTest) { card in
                                
                                CardView(card: card)
                                
                            }
                        }
                    }
                } .padding()
                .scrollIndicators(.hidden)
            
            } .ignoresSafeArea()
        }
    }


#Preview {
    // Je passe un utilisateur de type User, et je lui passe les données fictives (User.user) pour l’afficher
    ProfilView(user: User.user)
}
