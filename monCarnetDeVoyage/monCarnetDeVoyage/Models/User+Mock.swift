//
//  User+Mock.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 03/06/2026.
//

import SwiftUI


// Ajout de fonctionnalités au modèle via une extension sans modifier le model original.
extension User {
    
    // static let : accessible sans instanciation
    static let mockUsers: [User] = [
        User(pseudo: "Imane", photo: "userDefaut"),
        User(pseudo: "Momo", photo: "")
    ]
}
