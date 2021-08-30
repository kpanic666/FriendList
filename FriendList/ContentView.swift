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
      GeometryReader { geo in
        VStack {
          Image("friends")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: geo.size.width * 0.7)
          
          List {
            ForEach(userContainer.users) { user in
              NavigationLink(
                destination: DetailView(userContainer: userContainer, user: user),
                label: {
                  Text(user.name)
                })
            }
            .onDelete(perform: removeRows)
          }
          
          ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(white: 0.7, opacity: 0.8), Color.white]), startPoint: .bottom, endPoint: .top)
            VStack {
              TextField("URL for friend list loading", text: $loadURL)
              
              HStack {
                Button("Reload from Internet") {
                  do {
                    try userContainer.loadDataFromURL(string: loadURL)
                  } catch {
                    print("Can't load user data from provided URL.")
                  }
                }
                .padding()
              }
            }
          }
          .frame(height: geo.size.height * 0.1)
          
        }
      }
      .navigationBarTitle("My Friends")
      .navigationBarItems(leading: EditButton())
    }
  }
  
  func removeRows(at offsets: IndexSet) {
    userContainer.users.remove(atOffsets: offsets)
  }
  
  struct ContentView_Previews: PreviewProvider {
    static var userContainer = UserContainer(users: [User(name: "Peter Pen")])
    
    static var previews: some View {
      ContentView(userContainer: userContainer)
    }
  }
}
