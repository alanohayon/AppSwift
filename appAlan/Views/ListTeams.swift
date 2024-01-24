import SwiftUI

struct ListTeams: View {
//    On recupere l'id de la league, qui a été envoyé depuis NavigationLink dans ListLeagues
    let leagueId: Int
    
    var body: some View {
        Text("Détails de la Ligue \(leagueId)")
            .navigationTitle("Équipes")
    }
}

struct ListTeams_Previews: PreviewProvider {
    static var previews: some View {
        ListTeams(leagueId: 1)
    }
}
