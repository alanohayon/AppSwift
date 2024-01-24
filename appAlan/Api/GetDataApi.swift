import Foundation


class GetDataApi {
    let baseUrl = "https://www.thesportsdb.com/api/v1/json/50130162"
    
//    Fonction pour obtenir toutes les ligues de football
    func getAllLeagues(completion: @escaping ([League]?) -> Void) {
//        Modif de l'url, afin de preciser le football comme sport
//        J'utilise "search_all_leagues.php?s=Soccer"
        let leaguesSoccerUrl = "\(baseUrl)/search_all_leagues.php?s=Soccer"
        
//        Si la requete est invalide on retourne msg d'erreur
        guard let url = URL(string: leaguesSoccerUrl) else {
            print("L'URL est invalide !")
            completion(nil)
            return
        }
        
//        La variable task contient la fonction qui va executer le reg et recuperer les datas
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            On verifie si on a bien recu des données sinon on retourne msg d'erreur
//            guard verifie la condition, comme if mais doit tjrs avoir un else, il controle mieux les erreurs
            guard let data = data, error == nil else {
                print("Erreur lors de la récupération des données: \(error?.localizedDescription ?? "Erreur inconnue")")
                completion(nil)
                return
            }
            
//            On insert les données que l'on a predefinit dans League
            do {
                let leaguesData = try JSONDecoder().decode([String: [League]].self, from: data)
                let leagues = leaguesData["leagues"]
                completion(leagues)
            }
//            Si on a un erreur lors de l'insertion
            catch {
                print("Echec du décodage: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        // On lance la fonction
        task.resume()
    }
    
    // Fonction pour obtenir toutes les équipes d'une ligue
        func getTeamsLeague(forLeague strLeague: String, completion: @escaping ([Team]?) -> Void) {
            let teamsUrl = "\(baseUrl)/search_all_teams.php?l=\(strLeague)"
            
            guard let url = URL(string: teamsUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
                print("URL invalide.")
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Erreur lors de la récupération des données: \(error?.localizedDescription ?? "Erreur inconnue")")
                    completion(nil)
                    return
                }
                
                do {
                    let teamsData = try JSONDecoder().decode([String: [Team]].self, from: data)
                    completion(teamsData["teams"])
                } catch {
                    print("Échec du décodage JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            }
            task.resume()
        }
    
}


