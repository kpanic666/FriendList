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
//    var age: Int = 20
//    var company = ""
//    var email = ""
//    var address = ""
//    var about = ""
//    let registered: Date
//    var tags = [String]()
//    var friends = [Friend]()
    
    init(id: UUID, name: String, regDate: Date) {
        self.id = id
        self.name = name
//        self.registered = regDate
    }
    
    init(name: String) {
        self.init(id: UUID(), name: name, regDate: Date())
    }
}
