//
//  UsersListView.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import SwiftUI

struct UsersListView: View {
    @ObservedObject var usersRepo: UsersRepo

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(usersRepo.users) { user in
                        NavigationLink {
                            PostsListView(user: user)
                        } label: {
                            UserView(user: user)
                        }
                    }
                    .background(Color.white)
                    .listRowBackground(Color.white)
                    .listRowSeparator(.hidden)
                }
                .background(Color.white)
                .listStyle(PlainListStyle())
                .refreshable(action: {
                    usersRepo.getUsers()
                })
            }
            .background(Color.white)
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .white
        }
        .background(Color.white)
        .padding()
        .background(Color.white)
    }
}

struct UsersListView_Previews: PreviewProvider {
    static let repo = UsersRepo(showDemo: true)
    static var previews: some View {
        UsersListView(usersRepo: repo)
    }
}
