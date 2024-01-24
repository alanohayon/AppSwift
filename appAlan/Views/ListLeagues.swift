import SwiftUI

struct ListLeagues: View {
    @State private var leagues: [League] = []
    @State private var searchText = "" // Ajouté pour la recherche
    
    var body: some View {
        NavigationView {
            List(filteredLeagues, id: \.idLeague) { league in
                NavigationLink(destination: ListTeams(league: league)) {
                    HStack {
                        // Affichage de l'image, avec gestion de l'absence d'URL.
                        if let urlString = league.strBadge, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                        } else {
                            // Placeholder pour l'image en cas d'absence d'URL.
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                        VStack(alignment: .leading) {
                            Text(league.strLeague)
                                .fontWeight(.bold)
                            Text(league.strCountry ?? "Country not available")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Ligues")
            .searchable(text: $searchText, prompt: "Recherche") // Barre de recherche
            .onAppear {
                loadData()
            }
        }
    }
    
    private var filteredLeagues: [League] {
        if searchText.isEmpty {
            return leagues
        } else {
            return leagues.filter { $0.strLeague.contains(searchText) }
        }
    }
    
//    Fonction qui va chercher les données
    private func loadData() {
        GetDataApi().getAllLeagues { result in
            DispatchQueue.main.async {
                if let leagues = result {
                    self.leagues = leagues
                    // Affiche chaque nom de ligue dans les logs.
                    leagues.forEach { league in
                        print(league.strLeague)
                    }
                }
                else {
                    print("merde")
                }
            }
        }
    }
}
