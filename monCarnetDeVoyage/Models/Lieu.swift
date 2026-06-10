//
//  Card.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//



import Foundation


struct Lieu: Identifiable, Hashable {

    let id: UUID
    var photo: Data?
    var ville: String
    var pays: String
    var description: String
    var note: Int
    var statut: Statut
    var latitude: Double
    var longitude: Double


    enum Statut: String, CaseIterable {
        case visite = "Visité"
        case aVisiter = "À découvrir"
    }
    
}

