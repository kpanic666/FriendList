//
//  ContentView.swift
//  FriendList
//
//  Created by Andrei Korikov on 27.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    @State private var loadURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(users) {
                        Text($0.name)
                    }
                }
                
                TextField("URL for friend list loading", text: $loadURL)
                
                HStack {
                    Button("Reload from Internet") {
                        do { try loadDataFromURL(string: loadURL)
                        } catch {
                            print("Can't load user data from provided URL.")
                        }
                    }
                }
            }
            .navigationBarTitle("My Friends")
        }
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
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    DispatchQueue.main.async {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
