//
//  PostmanApp.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import SwiftUI

@main
struct PostmanApp: App {
    let users = UsersRepo()
    var body: some Scene {
        WindowGroup {
            UsersListView(usersRepo: users)
        }
    }
}
