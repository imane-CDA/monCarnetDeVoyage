import SwiftUI

struct ProfilView: View {

    var user: User

    @State private var recherche = ""
    @State private var lieux: [Lieu] = Lieu.cardTest
    @State private var ouvrirFormulaire = false
    @State private var filtreSelectionne: Filtre = .tous
    
    @State private var selectedLieuID: UUID?

    enum Filtre {
        case tous, visite, aVisiter
    }

    var lieuxFiltres: [Lieu] {
        let base = switch filtreSelectionne {
        case .tous: lieux
        case .visite: lieux.filter { $0.statut == .visite }
        case .aVisiter: lieux.filter { $0.statut == .aVisiter }
        }

        guard !recherche.isEmpty else { return base }

        return base.filter {
            $0.ville.localizedCaseInsensitiveContains(recherche) ||
            $0.pays.localizedCaseInsensitiveContains(recherche)
        }
    }

    var body: some View {

        NavigationStack {

            ZStack {
                Color.beigeClair.ignoresSafeArea()

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 18) {

                        VStack(alignment: .leading, spacing: 14) {

                            HStack {
                                Image(user.photo)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(user.pseudo)
                                        .font(.title2.bold())

                                    Text("Explore tes voyages ✈️")
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Button {
                                    ouvrirFormulaire = true
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .frame(width: 42, height: 42)
                                        .background(Color.bleuLagon)
                                        .clipShape(Circle())
                                }
                            }

                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.secondary)

                                TextField("Bali, Tokyo, Paris...", text: $recherche)
                            }
                            .padding(12)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal)

                        HStack {
                            VStack(alignment: .leading) {
                                Text("Mes destinations")
                                    .font(.title3.bold())

                                Text("\(lieuxFiltres.count) lieux")
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)

                        HStack(spacing: 10) {
                            filtreButton("Tous", .tous, .bleuLagon)
                            filtreButton("Visités", .visite, .violetPastel)
                            filtreButton("À découvrir", .aVisiter, .roseSoleil)
                        }
                        .padding(.horizontal)

                        VStack(spacing: 18) {
                            ForEach(lieuxFiltres) { lieu in
                                CardView(lieu: lieu)
                                    .allowsHitTesting(false)
                                    .contentShape(RoundedRectangle(cornerRadius: 28))
                                    .onTapGesture {
                                        selectedLieuID = lieu.id
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .id(filtreSelectionne)
                    }
                    .padding(.top, 10)
                }
            }
            
            .navigationDestination(item: $selectedLieuID) { idSelectionne in
                if let index = lieux.firstIndex(where: { $0.id == idSelectionne }) {
                    DetailCardView(
                        card: $lieux[index],
                        modifierLieu: modifierLieu,
                        supprimerLieu: supprimerLieu
                    )
                    .onDisappear {
                                recherche = "" 
                            }
                }
            }

            .sheet(isPresented: $ouvrirFormulaire) {
                AjoutCardView { nouveauLieu in
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        lieux.insert(nouveauLieu, at: 0)
                    }
                }
            }
        }
    }

    func filtreButton(_ title: String, _ filtre: Filtre, _ color: Color) -> some View {
        Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                filtreSelectionne = filtre
            }
            
        } label: {
            Text(title)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(filtreSelectionne == filtre ? color : .white)
                .foregroundStyle(filtreSelectionne == filtre ? .white : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }

    func modifierLieu(_ lieu: Lieu) {
        if let index = lieux.firstIndex(where: { $0.id == lieu.id }) {
            lieux[index] = lieu
        }
    }

    func supprimerLieu(_ lieu: Lieu) {
        selectedLieuID = nil
        withAnimation {
            lieux.removeAll { $0.id == lieu.id }
        }
    }
}

#Preview {
    ProfilView(user: User.user)
}
