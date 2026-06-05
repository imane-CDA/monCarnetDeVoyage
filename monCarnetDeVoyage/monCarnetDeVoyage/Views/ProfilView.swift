//
//  ProfilView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 03/06/2026.
//

import SwiftUI


struct ProfilView: View {
    
    
    // injecte user de type User (model User)
    var user: User
    
    // variable dynamique contenant la recherche utilisateur
    @State private var recherche = ""
    
    // variable dynamique contenant le tableau des lieux
    @State private var lieux = Lieu.cardTest
    
    // variable dynamique contenant tout les lieux
    @State private var filtreSelectionne: Filtre = .tous
    
    // enum --> statut des lieux
    enum Filtre {
        case tous
        case visite
        case aVisiter
    }
    
    // tableau des lieux en fonction de leurs status
    var lieuxFiltres: [Lieu] {
        switch filtreSelectionne {
        case .tous:
            return lieux
        case .visite:
            return lieux.filter { $0.visite }
        case .aVisiter:
            return lieux.filter { !$0.visite }
        }
    }
    
    // fonction bouton
     func filtreButton(_ titre: String, _ filtre: Filtre, _ couleur: Color) -> some View {
        
        Button {
            filtreSelectionne = filtre
        } label: {
            Text(titre)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(filtreSelectionne == filtre ? couleur : .white)
                .foregroundStyle(filtreSelectionne == filtre ? .white : couleur)
                .clipShape(Capsule())
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.beigeClair.ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 24) {
                    
                    // profil + ajouter + barre de recherche + boutons
                    VStack(spacing: 20) {
                        
                        HStack {
                            
                            // photo de profil
                            Image(user.photo)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(
                                            LinearGradient(
                                                colors: [.bleuLagon, .roseSoleil],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 4
                                        )
                                )
                            
                            VStack(alignment: .leading) {
                                
                                // pseudo
                                HStack {
                                    Text(user.pseudo)
                                        .font(.title)
                                        .bold()
                                }
                                
                                // description
                                Text("Passionnée de voyages ✨")
                                    .foregroundStyle(.gray)
                            }
                            
                            Spacer()
                            
                            // NavigationLink : Ajouter lieu
                            NavigationLink {
                                
                                AjoutCardView()
                                
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .frame(width: 35, height: 35)
                                    .background(Color.bleuLagon)
                                    .clipShape(Circle())
                            }
                        }
                        
                        // barre de recherche
                        HStack {
                            
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Bali, Tokyo, Paris...", text: $recherche)
                            
                        }
                        .padding(10)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        
                        // Titre
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Mes destinations")
                                    .font(.title2)
                                    .bold()
                                
                                // nbr lieux (tous, visité, à visité)
                                Text("\(lieuxFiltres.count) lieux")
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                        }
                        
                        // fonction boutons filtré (nom, statut, couleur)
                        HStack(spacing: 12) {
                            
                            filtreButton("Tous", .tous, .bleuLagon)
                            
                            filtreButton("Visités", .visite, .violetPastel)
                            
                            filtreButton("À découvrir", .aVisiter, .roseSoleil)
                        }
                    }
                    .padding()
                    
                    // LazyVStack affiche les lieux filtré
                    LazyVStack(spacing: 22) {
                                                    
                        // Boucle sur les lieux (status) pour afficher DetailCardView
                            ForEach(lieuxFiltres) { lieu in
                                
                                NavigationLink {
                                    DetailCardView(card: lieu)
                                } label: {
                                    CardView(lieu: lieu)
                                
                                }
                                .buttonStyle(.plain)
                                .buttonStyle(.plain)
                                .contentShape(Rectangle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }.scrollIndicators(.hidden)
                
            }
        }
    }


#Preview {

    NavigationStack {

        ProfilView(user: User.user)
    }
}
