import SwiftUI

struct ListLeagues: View {
//    Corp de de notre page
    var body: some View {
        NavigationView {
            List(0..<5) { index in
//                Permet d'etre rediriger vers une view avec les datas de la league
                NavigationLink(destination: ListTeams(leagueId: index)) {
//                    On affiche les datas que l'on souhaite pour chaque item (league)
                    Text("Ligue \(index)")
                }
            }
//            On affiche le titre de la view
            .navigationTitle("Ligues")
        }
    }
}

struct ListLeagues_Previews: PreviewProvider {
    static var previews: some View {
//        On active la view
        ListLeagues()
    }
}
