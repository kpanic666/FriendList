//
//  User.swift
//  FriendList
//
//  Created by Andrei Korikov on 27.08.2021.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    var name: String
}

struct User: Codable, Identifiable {
    let id: UUID
    var isActive = true
    var name: String
    var age: Int = 20
    var company = ""
    var email = ""
    var address = ""
    var about = ""
    let registered: String
    var tags = [String]()
    var friends = [Friend]()
    
    init(id: UUID, name: String, regDate: Date) {
        self.id = id
        self.name = name
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        self.registered = dateFormatter.string(from: regDate)
    }
    
    init(name: String) {
        self.init(id: UUID(), name: name, regDate: Date())
    }
}

class UserContainer: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case users
    }
    
    @Published var users: [User]
    
    init(users: [User]) {
        self.users = users
    }
    
    init() {
        users = [User]()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        users = try container.decode([User].self, forKey: .users)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(users, forKey: .users)
    }
    
    /// Renew data in the 'users' array from provided URL
    func loadDataFromURL(string: String) throws {
        guard let url = URL(string: string) else {
            print("Can't load Users from the Internet. Invalid ULR.")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    var decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    DispatchQueue.main.async {
                        decodedResponse.sort { user1, user2 in
                            user1.name < user2.name
                        }
                        self.users = decodedResponse
                    }
                } catch {
                    print(error.localizedDescription)
                }
                 
            } else {
                print("Can't load Users from the Internet. Fetch Failed.")
            }
        }.resume()
    }
    
    func addUser(_ user: User) {
        users.append(user)
    }
}
