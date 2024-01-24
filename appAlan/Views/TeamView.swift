import SwiftUI

struct TeamView: View {
    var team: Team

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: team.strTeamBadge ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)

            Text(team.strTeam)
                .font(.title)
                .padding()

            if let stadium = team.strStadium {
                Text("Stadium: \(stadium)")
                    .font(.subheadline)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle(team.strTeam)
    }
}
