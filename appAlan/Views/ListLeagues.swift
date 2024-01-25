import SwiftUI

struct ListLeagues: View {
    @State private var leagues: [League] = []
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
//            On recupere la list (que nous renvoie filter...) des leagues et on boucle sur chaque league
            List(filteredLeagues, id: \.idLeague) { league in
                NavigationLink(destination: ListTeams(league: league)) {
//                    HS pour un affichage horizontal, spacing pour l'ecart entre les element, .
                    HStack {
                        // if pck on est pas sur (?) qu'il y ai une valeur
                        // Affichage de l'image, avec gestion de l'absence d'URL.
                        if let urlString = league.strBadge, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
//                                On affiche rien si il n'y en a pas
//                                Color.gray
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
            // Barre de recherche
            .searchable(text: $searchText, prompt: "Recherche")
            .onAppear {
                loadData()
            }
        }
    }
    
    private var filteredLeagues: [League] {
//        Si rien n'ai saisi dans la barre de recherche
        if searchText.isEmpty {
            return leagues
        } else {
            return leagues.filter { $0.strLeague.contains(searchText) }
        }
    }
    
//    Fonction qui va charger les données depuis l'api
    private func loadData() {
        GetDataApi().getAllLeagues { result in
            DispatchQueue.main.async {
//                Si on recupere bien des données
                if let leagues = result {
                    self.leagues = leagues
                    print("Les ligues ont été récupéré avec succès.")
                }
                else {
                    print("Error: Les ligues n'ont pas pu être récupéré")
                }
            }
        }
    }
}
