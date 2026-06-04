//
//  Card+Mock.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

import SwiftUI

// Extension : utilisée pour ajouter des données de test au modèle Card
extension Card {
    
    // Données fictives 
    static let cardTest: [Card] = [
        
        Card(
            photo: "Lieu1",
            ville: "Māhina",
            pays: "Tahiti",
            description: "Tahiti est la plus grande île de la Polynésie française...",
            note: 4
        ),
        
        Card(
            photo: "Lieu1",
            ville: "Paris",
            pays: "France",
            description: "Paris est la capitale de la France, connue pour la Tour Eiffel et son patrimoine culturel.",
            note: 5
        ),
        
        Card(
            photo: "Lieu1",
            ville: "Tokyo",
            pays: "Japon",
            description: "Tokyo est une mégalopole moderne mêlant tradition et technologie.",
            note: 5
        ),
        
        Card(
            photo: "Lieu1",
            ville: "New York",
            pays: "USA",
            description: "New York est la ville qui ne dort jamais, célèbre pour Manhattan et Times Square.",
            note: 4
        ),
        
        Card(
            photo: "Lieu1",
            ville: "Rome",
            pays: "Italie",
            description: "Rome est une ville historique avec le Colisée et le Vatican.",
            note: 5
        )
    ]
}
