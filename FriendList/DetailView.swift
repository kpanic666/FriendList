//
//  DetailView.swift
//  FriendList
//
//  Created by Andrei Korikov on 30.08.2021.
//

import SwiftUI

struct DetailView: View {
  let userContainer: UserContainer
  
  @State var user: User
  
  var body: some View {
    //    ScrollView {
    VStack {
      Form {
        TextField("Name", text: $user.name)
        TextField("Company", text: $user.company)
        
        Stepper(value: $user.age, in: 0...120) {
          Text("Age:\t \(user.age)")
        }
        TextField("E-mail", text: $user.email)
      }
      
      
      HStack(alignment:.top, spacing: 20) {
        Text("About:")
          .bold()
          .font(.title3)
          .padding()
        TextEditor(text: $user.about)
          .multilineTextAlignment(.trailing)
          .foregroundColor(.secondary)
      }
      
      VStack {
        Text("Friends:")
          .font(.title3)
        
        List {
          ForEach(user.friends) { friend in
            if let destUser = userContainer.users.first { $0.id == friend.id } {
              NavigationLink(destination: DetailView(userContainer: userContainer, user: destUser)) {
                Text(friend.name)
              }
            }
          }
        }
        
        Button(action: {
          if let userIndex = userContainer.users.firstIndex(where: { $0.id == user.id }) {
            userContainer.users[userIndex].name = user.name
            userContainer.users[userIndex].age = user.age
            userContainer.users[userIndex].company = user.company
            userContainer.users[userIndex].email = user.email
            userContainer.users[userIndex].address = user.address
            userContainer.users[userIndex].about = user.about
          }
        }, label: {
          HStack {
            Image(systemName: "square.and.arrow.down.fill")
              .foregroundColor(.green)
            
            Text("Save")
          }
          .font(.title)
          
        })
      }
      //      }
    }
  }
}


struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    let userContainer = UserContainer()
    var user1 = User(name: "Anton Markov")
    user1.about = "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore."
    user1.company = "Imkan"
    user1.email = "kpanic666@gmail.com"
    user1.address = "907 Nelson Street, Cotopaxi, South Dakota, 5913"
    return DetailView(userContainer: userContainer, user: user1)
  }
}
