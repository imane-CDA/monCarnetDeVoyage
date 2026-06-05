//
//  test.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 05/06/2026.
//

import SwiftUI

struct test: View {
    var body: some View {
        ScrollView {
            VStack {
                
                ConcentricRectangle(
                    topLeadingCorner: .concentric(minimum: 32),
                    topTrailingCorner: .concentric,
                    bottomLeadingCorner: .concentric,
                    bottomTrailingCorner: .concentric
                )
                .fill(Color.blue)
                .frame(minHeight: 300)
                
            }
        }
    }
}

#Preview {
    test()
}
