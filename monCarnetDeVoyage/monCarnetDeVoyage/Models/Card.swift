//
//  Card.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

import SwiftUI

struct Card: Identifiable {
    
    var id = UUID()
    var photo : String
    var ville : String
    var pays : String
    var description : String
    var note : Int

}


