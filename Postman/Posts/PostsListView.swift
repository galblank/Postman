//
//  PostsListView.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import SwiftUI

struct PostsListView: View {
    let user: User
    @ObservedObject var postsRepo = PostsRepo()
    @State var displayNewPost = false
    var body: some View {
        VStack {
            addNewPostButton()
            List {
                ForEach(postsRepo.posts) { post in
                    PostView(post: post)
                }
                .listRowBackground(Color.white)
                .listRowSeparator(.hidden)
            }
            .background(Color.white)
            .listStyle(GroupedListStyle())
            .refreshable(action: {
                postsRepo.getPostsFor(for: user.id)
            })
        }
        .navigationTitle("\(user.username ?? "Username")'s Posts")
        .onAppear(perform: {
            postsRepo.getPostsFor(for: user.id)
        })
        .padding()
    }

    private func addNewPostButton() -> some View {
        return HStack {
            Spacer()
            Button {
                // Load post screen with for new post
                displayNewPost.toggle()
            } label: {
                Text("Create new post")
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .lineLimit(1)
                    .font(.caption)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(15.0)
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .sheet(isPresented: $displayNewPost) {
                EditPostView(postForUser: user)
                    .environmentObject(postsRepo)
             }
            Spacer()
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var user = User(id: 1, name: "Milton", username: "Waddams", email: "milton@initech.com", address: ["street": "Main"], phone: "34535", website: "ewrwer.ww.com", company: ["name": "Initech"])
    static var previews: some View {
        PostsListView(user: user)
    }
}
