//
//  Card.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

import SwiftUI

struct Lieu: Identifiable {
    
    var id = UUID()
    var photo : String
    var ville : String
    var pays : String
    var description : String
    var note : Int
    var visite: Bool
    
    
    // CaseIterable : type qui fournit une collection de toutes ses valeurs.
//    enum statut : CaseIterable {
//        case aVisiter,
//        case dejaVisiter
//    }

}


