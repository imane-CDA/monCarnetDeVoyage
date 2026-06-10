//
//  Card+Mock.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//


import UIKit

extension Lieu {

    var uiImage: UIImage? {
        guard let photo else { return nil }
        return UIImage(data: photo)
    }

    static let cardTest: [Lieu] = [

        Lieu(
            id: UUID(),
            photo: UIImage(named: "Lieu1")?.jpegData(compressionQuality: 1),
            ville: "Paris",
            pays: "France",
            description: "Ville lumière",
            note: 4,
            statut: .visite,
            latitude: 48.8566,
            longitude: 2.3522
        ),

        Lieu(
            id: UUID(),
            photo: UIImage(named: "Lieu2")?.jpegData(compressionQuality: 1),
            ville: "Tokyo",
            pays: "Japon",
            description: "Mégapole moderne",
            note: 5,
            statut: .aVisiter,
            latitude: 35.6762,
            longitude: 139.6503
        )
    ]
}
