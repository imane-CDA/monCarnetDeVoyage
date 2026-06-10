//
//  ModifierCardView.swift
//  monCarnetDeVoyage
//
//  Created by Apprenant131 on 05/06/2026.
//

import SwiftUI
import PhotosUI

struct ModifierCardView: View {

    @Environment(\.dismiss) var dismiss

    @Binding var lieu: Lieu
    var modifierLieu: (Lieu) -> Void
    var supprimerLieu: (Lieu) -> Void
    var onSave: (() -> Void)?
    var onDelete: (() -> Void)?

    @State private var afficherAlerteSuppression = false

    @State private var imageSelectionnee: PhotosPickerItem?
    @State private var donneesImage: Data?

    @State private var ville: String
    @State private var pays: String
    @State private var description: String
    @State private var note: Int
    @State private var statut: Lieu.Statut

    var formulaireValide: Bool {
        !ville.isEmpty && !pays.isEmpty && !description.isEmpty
    }

    init(
        lieu: Binding<Lieu>,
        modifierLieu: @escaping (Lieu) -> Void,
        supprimerLieu: @escaping (Lieu) -> Void,
        onSave: (() -> Void)? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self._lieu = lieu
        self.modifierLieu = modifierLieu
        self.supprimerLieu = supprimerLieu
        self.onSave = onSave
        self.onDelete = onDelete

        _ville = State(initialValue: lieu.wrappedValue.ville)
        _pays = State(initialValue: lieu.wrappedValue.pays)
        _description = State(initialValue: lieu.wrappedValue.description)
        _note = State(initialValue: lieu.wrappedValue.note)
        _statut = State(initialValue: lieu.wrappedValue.statut)
        _donneesImage = State(initialValue: lieu.wrappedValue.photo)
    }

    var body: some View {

        ZStack {
            Color.beigeClair.ignoresSafeArea()

            ScrollView {

                VStack(spacing: 22) {

                    VStack(spacing: 6) {
                        HStack {
                            Text("Modifier la destination")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }

                        Text("Mets à jour ton carnet de voyage")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top)

                    VStack(spacing: 12) {

                        ZStack {
                            if let data = donneesImage ?? lieu.photo,
                               let uiImage = UIImage(data: data) {

                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                                    .clipped()

                            } else {

                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .frame(height: 250)
                                    .overlay {
                                        VStack(spacing: 6) {
                                            Image(systemName: "photo")
                                                .font(.system(size: 35))
                                            Text("Aucune image")
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.gray.opacity(0.15), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)

                        PhotosPicker(
                            selection: $imageSelectionnee,
                            matching: .images
                        ) {
                            Label("Changer l’image", systemImage: "photo.badge.plus")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.bleuLagon)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .onChange(of: imageSelectionnee) { _, newValue in
                            Task {
                                guard let item = newValue,
                                      let data = try? await item.loadTransferable(type: Data.self),
                                      let uiImage = UIImage(data: data)
                                else { return }

                                donneesImage = uiImage.jpegData(compressionQuality: 0.8)
                            }
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 12) {

                        HStack {
                            Image(systemName: "building.2.fill")
                                .foregroundStyle(.roseSoleil)

                            TextField("Ville", text: $ville)
                        }

                        Divider()

                        HStack {
                            Image(systemName: "globe.europe.africa.fill")
                                .foregroundStyle(.roseSoleil)

                            TextField("Pays", text: $pays)
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray.opacity(0.08))
                    )
                    .shadow(color: .black.opacity(0.05), radius: 6)
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {

                        Text("Description")
                            .font(.headline)

                        ZStack(alignment: .topLeading) {

                            if description.isEmpty {
                                Text("Décris ton expérience...")
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                            }

                            TextEditor(text: $description)
                                .frame(height: 120)
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.05), radius: 6)
                    .padding(.horizontal)

                    VStack(spacing: 12) {

                        HStack {
                            Text("Note")
                                .font(.headline)

                            Spacer()

                            Text("\(note)/5")
                                .fontWeight(.semibold)
                        }

                        HStack {
                            Spacer()

                            ForEach(1...5, id: \.self) { i in
                                Image(systemName: i <= note ? "star.fill" : "star")
                                    .font(.title3)
                                    .foregroundStyle(.yellow)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.25)) {
                                            note = i
                                        }
                                    }
                            }

                            Spacer()
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.05), radius: 6)
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Statut")
                            .font(.headline)

                        HStack(spacing: 12) {

                            ForEach(Lieu.Statut.allCases, id: \.self) { s in

                                Button {
                                    withAnimation(.spring()) {
                                        statut = s
                                    }
                                } label: {
                                    Text(s.rawValue)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(
                                            statut == s ? Color.bleuLagon : .white
                                        )
                                        .foregroundStyle(
                                            statut == s ? .white : .primary
                                        )
                                        .clipShape(Capsule())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.05), radius: 6)
                    .padding(.horizontal)

                    VStack(spacing: 12) {

                        Button {
                            let updated = Lieu(
                                id: lieu.id,
                                photo: donneesImage ?? lieu.photo,
                                ville: ville,
                                pays: pays,
                                description: description,
                                note: note,
                                statut: statut,
                                latitude: lieu.latitude,
                                longitude: lieu.longitude 
                            )

                            modifierLieu(updated)
                            onSave?()
                            dismiss()

                        } label: {
                            Text("Enregistrer les modifications")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    formulaireValide
                                    ? Color.bleuLagon
                                    : Color.gray.opacity(0.4)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                        .disabled(!formulaireValide)

                        Button(role: .destructive) {
                            afficherAlerteSuppression = true
                        } label: {
                            Label("Supprimer du carnet", systemImage: "trash")
                                .font(.headline)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(.red.opacity(0.25))
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 30)
                }
            }
            .scrollIndicators(.hidden)
        }
        .alert("Supprimer le lieu ?", isPresented: $afficherAlerteSuppression) {

            Button("Supprimer", role: .destructive) {
                supprimerLieu(lieu)
                onDelete?()
                dismiss()
            }

            Button("Annuler", role: .cancel) { }

        } message: {
            Text("Es-tu sûr de vouloir retirer \(ville) de ton carnet ?")
        }
    }
}

#Preview {
    ModifierCardView(
        lieu: .constant(Lieu(
            id: UUID(),
            photo: nil,
            ville: "Paris",
            pays: "France",
            description: "Ville lumière",
            note: 4,
            statut: .visite,
            latitude: 48.8566,
            longitude: 2.3522
        )),
        modifierLieu: { _ in },
        supprimerLieu: { _ in }
    )
}
