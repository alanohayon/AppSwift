import Foundation


struct League: Codable {
    let idLeague: String
    let strLeague: String
    let strCountry: String?
    let strBadge: String?
    var id: String { idLeague }
}
