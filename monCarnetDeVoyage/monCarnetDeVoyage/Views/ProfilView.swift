//
//  ContentView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 03/06/2026.
//

import SwiftUI

struct ProfilView: View {
    
    // tableau de User injecté depuis l'extérieur pour construire l'UI
    var users: [User]
    
    var body: some View {
        VStack {
            ForEach(users) { user in
                HStack {
                    Image(user.photo)
                        .resizable()
                        .frame(width: 250, height: 250)
                        
                    Text(user.pseudo)
                        .font(.largeTitle)
                }
            }
        }
        .padding()
    }
}


#Preview {
    // Injection de données mock pour tester le rendu de la vue
    ProfilView(users: User.mockUsers)
}
