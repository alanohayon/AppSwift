import SwiftUI

struct ListTeams: View {
    var league: League
    @State private var teams: [Team] = []
    @State private var searchText = ""

    var body: some View {
//        On recupere la list (que nous renvoie filter...) des teams et on boucle sur chaque team
        List(filteredTeams, id: \.idTeam) { team in
            NavigationLink(destination: TeamView(team: team)) {
//                HS pour un affichage horizontal, spacing pour l'ecart entre les element, ..
                HStack {
//                    On affiche l'image de l'equipe avec du style
//                    Fct asyn afin quelle charge en arrire plan et attendre le resultat
                    AsyncImage(url: URL(string: team.strTeamBadge ?? "")) { image in
                        image.resizable()
                    } placeholder: {
//                        On affiche rien si il n'y en a pas
//                        Color.gray
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)

//                    On affiche les autres informations
                    VStack(alignment: .leading) {
                        Text(team.strTeam)
                            .fontWeight(.bold)
                        // if pck on est pas sur (?) qu'il y ai une valeur
                        if let year = team.intFormedYear {
                            Text("Depuis: \(year)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Equipes")
        // Barre de recherche
        .searchable(text: $searchText, prompt: "Recherche")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
//            Afin de la ligue qu'on affiche en haut dans la toolbar
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(league.strLeague)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(league.strCountry ?? "Pays indisponible")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
//        On appelle loadData() afin de charger les données
        .onAppear {
        loadData()
        }
    }
    
    private var filteredTeams: [Team] {
//        Si rien n'ai saisi dans la barre de recherche
        if searchText.isEmpty {
            return teams
        } else {
//            Fct filter qui nous permet de chercher un element dans la list
            return teams.filter { $0.strTeam.contains(searchText) }
        }
    }
    
//    Fonction qui va charger les données depuis l'api
    private func loadData() {
        GetDataApi().getTeamsLeague(forLeague: league.strLeague) { result in
            DispatchQueue.main.async {
//                Si on recupere bien des données
                if let teams = result {
                    self.teams = teams
                    print("Les équipes ont été récupéré avec succès.")
                }
                else {
                    print("Error: Les équipes n'ont pas pu être récupéré.")
                }
            }
        }
    }
}
