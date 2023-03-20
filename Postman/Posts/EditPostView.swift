//
//  EditPostView.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import SwiftUI
import Alamofire

struct EditPostView: View {
    var postForUser: User?
    var existinPost: Post?
    @State var titleText = ""
    @State var descriptionText = ""
    /// Whether the user is focused on this `TextField`.
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    /// This can be replaced with protocol as well
    @EnvironmentObject var postsRepo: PostsRepo

    var border: some View {
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(
                .blue,
                lineWidth: isEditing ? 4 : 2
            )
    }

    var body: some View {
        VStack {
            Text("Creating new post on\n\(postForUser?.username ?? "Username")'s timeline")
                .foregroundColor(.blue)
                .font(.title)
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .padding()
            TextField("Title", text: $titleText)
                .lineLimit(2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
                .multilineTextAlignment(.leading)
                .accentColor(.blue)
                .foregroundColor(.black)
                .font(.headline)
                .background(border)
                .padding()
            TextField("Body", text: $descriptionText, axis: .vertical)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
                .multilineTextAlignment(.leading)
                .accentColor(.blue)
                .foregroundColor(.black)
                .font(.subheadline)
                .background(border)
                .padding()
            addNewPostButton()
                .padding()
        }
        .onAppear {
            if let post = existinPost {
                titleText = post.title
                descriptionText = post.body
            }
        }
    }

    private func addNewPostButton() -> some View {
        return HStack {
            Button {
                var url = "https://jsonplaceholder.typicode.com/posts?"
                var httpMethod = HTTPMethod.post
                if let postId = existinPost?.post?["id"] as? Int {
                    url += "id\(postId)"
                    httpMethod = .patch
                } else if let userId = postForUser?.id as? Int {
                    url += "userId\(userId)"
                } else {
                    return
                }
                // Load post screen with for new post
                let postData = ["title": self.titleText, "body": self.descriptionText]
                Helpers.sharedInstance.showNewActivity()
                AF.request(url,
                           method: httpMethod,
                           parameters: postData,
                           encoder: JSONParameterEncoder.default).response { response in
                    Helpers.sharedInstance.hideNewActivity()
                    dismiss()
                }
            } label: {
                    Text("Post")
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .lineLimit(1)
                        .font(.title3)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(15.0)

            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .frame(minWidth: 100, maxWidth: .infinity)
        }
    }
}

struct EditPostView_Previews: PreviewProvider {
    static var user = User(id: 1, name: "Milton", username: "Waddams", email: "milton@initech.com", address: ["street": "Main"], phone: "34535", website: "ewrwer.ww.com", company: ["name": "Initech"])
    static var previews: some View {
        EditPostView(postForUser: user)
    }
}
