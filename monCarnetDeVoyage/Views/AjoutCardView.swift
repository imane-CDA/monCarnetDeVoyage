//
//  AjoutCardView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 04/06/2026.
//

import SwiftUI
import PhotosUI

struct AjoutCardView: View {

    @Environment(\.dismiss) var dismiss
    var ajouterLieu: (Lieu) -> Void

    @State private var imageSelectionnee: PhotosPickerItem?
    @State private var donneesImage: Data?

    @State private var ville = ""
    @State private var pays = ""
    @State private var description = ""
    @State private var note = 1
    @State private var statut: Lieu.Statut = .aVisiter
    
    @State private var latitude: Double = 48.8566
    @State private var longitude: Double = 2.3522

    var formulaireValide: Bool {
        !ville.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !pays.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack {
            Color("beigeClair").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 18) {

                    VStack(spacing: 10) {
                        ZStack {
                            if let data = donneesImage, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 260)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                            } else {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .frame(height: 260)
                                    .overlay {
                                        VStack(spacing: 8) {
                                            Image(systemName: "photo.on.rectangle.angled")
                                                .font(.system(size: 34))
                                                .foregroundStyle(.gray.opacity(0.6))
                                            Text("Ajoute une photo").foregroundStyle(.secondary)
                                        }
                                    }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.08), radius: 10, y: 5)

                        PhotosPicker(selection: $imageSelectionnee, matching: .images) {
                            Text("Changer l’image")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color("bleuLagon"))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .onChange(of: imageSelectionnee) { _, newValue in
                            Task {
                                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                    donneesImage = data
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 14) {
                        VStack(spacing: 12) {
                            TextField("Ville", text: $ville)
                            Divider()
                            TextField("Pays", text: $pays)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description").font(.headline)
                            TextEditor(text: $description).frame(minHeight: 110)
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        HStack {
                            Text("Note").font(.headline)
                            Spacer()
                            ForEach(1...5, id: \.self) { i in
                                Image(systemName: i <= note ? "star.fill" : "star")
                                    .foregroundStyle(.yellow)
                                    .onTapGesture { note = i }
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        HStack(spacing: 10) {
                            ForEach(Lieu.Statut.allCases, id: \.self) { s in
                                Text(s.rawValue)
                                    .font(.subheadline)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                                    .background(statut == s ? Color("roseSoleil") : .white)
                                    .foregroundStyle(statut == s ? .white : .primary)
                                    .clipShape(Capsule())
                                    .onTapGesture { statut = s }
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.horizontal)

                    Button {
                        let nouveauLieu = Lieu(
                            id: UUID(),
                            photo: donneesImage,
                            ville: ville,
                            pays: pays,
                            description: description,
                            note: note,
                            statut: statut,
                            latitude: latitude,
                            longitude: longitude
                        )
                        ajouterLieu(nouveauLieu)
                        dismiss()
                    } label: {
                        Text("Ajouter le lieu")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(formulaireValide ? Color("roseSoleil") : .gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .disabled(!formulaireValide)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    AjoutCardView(ajouterLieu: { _ in })
}
