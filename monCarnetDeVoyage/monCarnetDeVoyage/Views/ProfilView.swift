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
    
    // variable dynamique pour la barre de recherche
    @State private var recherche = ""
    
    var body: some View {
        
        // permet la navigation vers d'autres écrans
        NavigationStack {
            
            ZStack {
                
                 
//                 Color(.fondBleu)
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        
                        // Hstack image + pseudo
                        HStack {
                            
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
                                .padding()
                            
                            // pseudo
                            Text(user.pseudo)
                                .font(.largeTitle)
                                .bold()
                            
                            Spacer()
                            
                        } .padding(.horizontal, 30)
                        
                        // barre de recherche EN COURS
//                        TextField("Rechercher un lieu", text: $recherche)
//                            .submitLabel(.done)
//                            .textFieldStyle(.roundedBorder)
//                            .autocorrectionDisabled()
                        
                        
                        // Titre -> mes lieux visités
                        HStack {
                            Text("Mes lieux visités")
                                .font(.title2)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            
                            // Bouton navigation vers écran détail
                            NavigationLink {
                                
                                AjoutCardView()
                                
                            } label: {
                                
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.green)
                                
                            }
                        } .padding(.horizontal, 30)
                        
                        VStack(spacing: 16) {
                            
                            // Parcourt toutes les cartes du tableau Card.cardTest
                            ForEach(Card.cardTest) { card in
                                
                                // Rend chaque carte cliquable
                                NavigationLink {
                                    
                                    DetailCardView()
                                    
                                } label: {
                                    
                                    // card : (Card.cardTest) → la liste complète
                                    // card : carte actuel (foreach)
                                    CardView(card: card)
                                        .padding(.horizontal)
                                }
                                
                                // supprime le style par défaut
                                .buttonStyle(.plain)
                            }
                        }
                    }
                } .scrollIndicators(.hidden)
            }
        }
    }
}


#Preview {
    // Je passe un utilisateur de type User, et je lui passe les données fictives (User.user) pour l’afficher
    ProfilView(user: User.user)
}

