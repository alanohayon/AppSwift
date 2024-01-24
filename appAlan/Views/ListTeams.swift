import SwiftUI

struct ListTeams: View {
    var league: League
    @State private var teams: [Team] = []

    var body: some View {
        List(teams, id: \.idTeam) { team in
            NavigationLink(destination: TeamView(team: team)) {
                HStack {
////                    On affiche la banniere
//                    AsyncImage(url: URL(string: team.strTeamFanart1 ?? "")) { image in
//                        image.resizable()
//                    } placeholder: {
//                        Color.gray
//                    }
//                    .cornerRadius(8)
                    
//                    On affiche l'image de l'equipe avec du style
                    AsyncImage(url: URL(string: team.strTeamBadge ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)

//                    On affiche les autres informations
                    VStack(alignment: .leading) {
                        Text(team.strTeam)
                            .fontWeight(.bold)
                        if let year = team.intFormedYear {
                            Text("Depuis: \(year)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Ligue:")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(league.strLeague) // Titre
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(league.strCountry ?? "Country not available") // Sous-titre
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear {
        loadData()
        }
    }

    private func loadData() {
        GetDataApi().getTeamsLeague(forLeague: league.strLeague) { result in
            DispatchQueue.main.async {
                self.teams = result ?? []
            }
        }
    }
}
