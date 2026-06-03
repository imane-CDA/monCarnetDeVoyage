//
//  monCarnetDeVoyageApp.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 03/06/2026.
//

import SwiftUI

@main
struct monCarnetDeVoyageApp: App {
    var body: some Scene {
        WindowGroup {
            ProfilView(users: User.mockUsers)
        }
    }
}
