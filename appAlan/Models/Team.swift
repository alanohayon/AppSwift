import Foundation


struct Team: Codable {
    let idTeam: String
    let strTeam: String
    let strTeamShort: String?
    let intFormedYear: String?
    let strStadium: String?
    let strTeamBadge: String?
    let strTeamBanner: String?
    let strTeamFanart1: String?
    var id: String { idTeam }
}
