import Foundation


struct League: Codable {
    let idLeague: String
    let strLeague: String
    let strCountry: String?
    let strBadge: String?
//    Pour que League soit identifiable
    var id: String { idLeague }
}
