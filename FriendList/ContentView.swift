//
//  ContentView.swift
//  FriendList
//
//  Created by Andrei Korikov on 27.08.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userContainer = UserContainer()
    
    @State private var loadURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(userContainer.users) {
                        Text($0.name)
                    }
                }
                
                TextField("URL for friend list loading", text: $loadURL)
                
                HStack {
                    Button("Reload from Internet") {
                        do { try userContainer.loadDataFromURL(string: loadURL)
                        } catch {
                            print("Can't load user data from provided URL.")
                        }
                    }
                }
            }
            .navigationBarTitle("My Friends")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
