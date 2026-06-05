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

    // Enum filtre
    enum Filtre {
        case tous
        case visite
        case aVisiter
    }

    // Variable dynamiique type enum
    @State private var filtreSelectionne: Filtre = .tous

    // switch retourne les cartes en fonction de l'enum filtre
    var lieuxFiltres: [Lieu] {
        
        switch filtreSelectionne {
        case .tous:
            return Lieu.cardTest

        case .visite:
            return Lieu.cardTest.filter { $0.visite }

        case .aVisiter:
            return Lieu.cardTest.filter { !$0.visite }
        }
    }

    var body: some View {

    

        
        // permet la navigation vers d'autres écrans

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
                                .stroke(.white.opacity(0.6), lineWidth: 3)
                        )
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    
                    // pseudo
                    
                    HStack {
                        Text(user.pseudo)
                            .font(.largeTitle)
                            
                        
                        Image(systemName: "map.fill")
                            .font(.title2)
                            .foregroundStyle(Color(.pink).opacity(0.6))
                        
                        Spacer()
                        
                    }.foregroundStyle(Color(.cyan))
                     .bold()
                     .padding(.horizontal)
                }

                // barre de recherche EN COURS
                //                        TextField("Rechercher un lieu", text: $recherche)
                //                            .submitLabel(.done)
                //                            .textFieldStyle(.roundedBorder)
                //                            .autocorrectionDisabled()
                

                // Titre -> mes lieux visités
                HStack {
                    
                   if filtreSelectionne == .tous {
                        Text("Mes lieux...")
                            .font(.title3)
                            .foregroundStyle(.gray)
                   } else if filtreSelectionne == .aVisiter {
                       Text("Mes lieux à visités...")
                           .font(.title3)
                           .foregroundStyle(.gray)
                   } else {
                       Text("Mes lieux visités...")
                           .font(.title3)
                           .foregroundStyle(.gray)
                   }
                        
                    Spacer()

                    // Bouton navigation vers écran ajoutCard
                    NavigationLink{

                        AjoutCardView()

                    } label: {

                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundStyle(.green)

                    }

                } .padding(.horizontal, 30)

                
                // Hstack tous - visité - à visiter
                HStack {

                    // Button TOUS
                    Button {
                        filtreSelectionne = .tous
                    } label: {
                        Text("Tous")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(
                                filtreSelectionne == .tous
                                    ? .white : .cyan.opacity(0.6)
                            )
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                            .background(
                                filtreSelectionne == .tous
                                    ? Color.cyan.opacity(0.6)
                                    : Color.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.cyan.opacity(0.6), lineWidth: 1)
                            }
                    }

                    Button {
                        filtreSelectionne = .visite
                    } label: {
                        Text("Visité")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(
                                filtreSelectionne == .visite
                                    ? .white : .purple.opacity(0.6)
                            )
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                            .background(
                                filtreSelectionne == .visite
                                    ? Color.purple.opacity(0.6)
                                    : Color.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.purple.opacity(0.6), lineWidth: 1)
                            }
                    }

                    Button {
                        filtreSelectionne = .aVisiter
                    } label: {
                        Text("À visiter")
                            .font(.headline)
                            .bold()
                            .foregroundStyle(
                                filtreSelectionne == .aVisiter
                                    ? .white : .pink.opacity(0.6)
                            )
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                            .background(
                                filtreSelectionne == .aVisiter
                                    ? Color.pink.opacity(0.6)
                                    : Color.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.pink.opacity(0.6), lineWidth: 1)
                            }
                    }

                }
            }
                
                VStack(spacing: 16) {

                    // Parcourt toutes les cartes du tableau Card.cartesFiltrees (switch)
                    ForEach(lieuxFiltres) { lieu in

                        NavigationLink {

                            DetailCardView(card : Lieu.cardTest[0])

                        } label: {

                            CardView(lieu: lieu)
                        }
                        // rectangle contenant la carte (sans débordement)
                        .contentShape(Rectangle())
                        .buttonStyle(.plain)
                    }
                }
            } .scrollIndicators(.hidden)
    }
}

#Preview {
    // Je passe un utilisateur de type User, et je lui passe les données fictives (User.user) pour l’afficher
    NavigationStack {

        ProfilView(user: User.user)
        
    }

}
