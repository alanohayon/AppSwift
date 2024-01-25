import SwiftUI

struct TeamView: View {
    var team: Team

    var body: some View {
//        VS pour un affichage vertical, spacing pour l'ecart entre les element, ..
        VStack(alignment: .leading) {
//            On affiche la banniere
            AsyncImage(url: URL(string: team.strTeamBanner ?? "")) { image in
                image.resizable()
            } placeholder: {
//                On affiche rien si il n'y en a pas
//                Color.gray
            }
            .frame(height: 100.0)
            .cornerRadius(2)
        }
        
        HStack(alignment: .center, spacing: 0.0) {
            //            On affiche le logo
            AsyncImage(url: URL(string: team.strTeamBadge ?? "")) { image in
                image.resizable()
            } placeholder: {
//                On affiche rien si il n'y en a pas
//                Color.gray
            }
            .frame(width: 60.0, height: 60.0)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
//                if pck on est pas sur (?) qu'il y ai une valeur
                if let teamShortName = team.strTeamShort {
                    Text(teamShortName)
                        .fontWeight(.semibold)
                        .lineLimit(nil)
                        .padding(.leading, 4.0)
                }
                
//                Nom complet de l'equipe
                Text(team.strTeam)
                    .font(.subheadline)
                    .padding(.leading, 6.0)
                
//                    Année de formation
                if let formationYear = team.intFormedYear {
                    Text("Since \(formationYear)")
                        .font(.subheadline)
                        .padding(.leading, 6.0)
                }
            }
            
        }
        .alignmentGuide(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Guide@*/.trailing/*@END_MENU_TOKEN@*/) { dimension in
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/dimension[.top]/*@END_MENU_TOKEN@*/
        }
        
        if let stadium = team.strStadium {
            Text("Stade: \(stadium)")
                .font(.subheadline)
                .padding()
        }
//            On affiche la banniere
            AsyncImage(url: URL(string: team.strTeamFanart1 ?? "")) { image in
                image.resizable()
            } placeholder: {
//                On affiche rien si il n'y en a pas
//                Color.gray
            }
            .frame(height: 200.0)
            .cornerRadius(10)
      
        
        .navigationTitle(team.strTeam)
    }
}

