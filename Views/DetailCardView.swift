import SwiftUI
import MapKit

struct DetailCardView: View {

    @Environment(\.dismiss) var dismiss
    @Binding var card: Lieu

    var modifierLieu: (Lieu) -> Void
    var supprimerLieu: (Lieu) -> Void

    @State private var showEdit = false
    @State private var showDeleteAlert = false
    
    private var mapPosition: MapCameraPosition {
        .region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: card.latitude, longitude: card.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        ZStack {
            Color("beigeClair").ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    GeometryReader { geo in
                        ZStack(alignment: .bottomLeading) {
                            if let data = card.photo, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geo.size.width, height: 360)
                                    .clipped()
                            } else {
                                Color.gray.opacity(0.2)
                                    .frame(width: geo.size.width, height: 360)
                            }
                            LinearGradient(colors: [.clear, .black.opacity(0.5)], startPoint: .center, endPoint: .bottom)
                        }
                    }
                    .frame(height: 360)
                    .clipped()
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(card.ville).font(.system(size: 34, weight: .bold)).foregroundStyle(.white)
                            Text(card.pays).foregroundStyle(.white.opacity(0.85))
                        }
                        .padding(20)
                    }

                    VStack(spacing: 16) {
                        
                        HStack(spacing: 12) {
                            HStack(spacing: 4) {
                                ForEach(1...5, id: \.self) { i in
                                    Image(systemName: i <= card.note ? "star.fill" : "star")
                                        .foregroundStyle(i <= card.note ? .yellow : .gray.opacity(0.3))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(14)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.08), radius: 8, y: 4)

                            Text(card.statut.rawValue)
                                .font(.subheadline.weight(.semibold))
                                .frame(maxWidth: .infinity)
                                .padding(14)
                                .background(Color("bleuLagon"))
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
                        }
                        .padding(.horizontal, 16)
                        .offset(y: -25)
                        .padding(.bottom, -25)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("À propos").font(.headline)
                            Text(card.description.isEmpty ? "Aucune description pour ce lieu" : card.description)
                                .foregroundStyle(.secondary)
                                .lineSpacing(5)
                        }
                        .padding(18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.05), radius: 10)

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Localisation").font(.headline)
                                Spacer()
                                Image(systemName: "map.fill").foregroundStyle(Color("roseSoleil"))
                            }
                            
                            Map(initialPosition: mapPosition) {
                                Annotation(card.ville, coordinate: CLLocationCoordinate2D(latitude: card.latitude, longitude: card.longitude)) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.title)
                                        .foregroundStyle(.red)
                                }
                            }
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(18)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.05), radius: 10)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 40)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showEdit = true } label: { Image(systemName: "square.and.pencil") }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .destructive) { showDeleteAlert = true } label: { Image(systemName: "trash") }
            }
        }
        .alert("Supprimer ce lieu ?", isPresented: $showDeleteAlert) {
            Button("Supprimer", role: .destructive) {
                withAnimation(.easeInOut) { supprimerLieu(card); dismiss() }
            }
            Button("Annuler", role: .cancel) {}
        }
        .sheet(isPresented: $showEdit) {
            ModifierCardView(
                lieu: $card,
                modifierLieu: modifierLieu,
                supprimerLieu: supprimerLieu,
                onSave: { showEdit = false },
                onDelete: { showEdit = false; dismiss() }
            )
        }
    }
}


#Preview {
    DetailCardView(
        card: .constant(Lieu.cardTest[0]),
        modifierLieu: { _ in },
        supprimerLieu: { _ in }
    )
}
