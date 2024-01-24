import SwiftUI

struct LeagueView: View {
    var league: League

    var body: some View {
        VStack {
            if let urlString = league.strBadge, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            }

            Text(league.strLeague)
                .font(.title)
                .padding()

            if let country = league.strCountry {
                Text(country)
                    .font(.subheadline)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle(league.strLeague)
    }
}
