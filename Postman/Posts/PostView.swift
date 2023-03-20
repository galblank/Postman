//
//  PostView.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//
import SwiftUI

struct PostView: View {
    var post: Post?
    @State var displayEditPost = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(post?.title ?? "Title")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                        .font(.headline)
                    Text(post?.body ?? "Body")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                        .font(.subheadline)
                }

                Button {
                    // Load post screen with for new post
                    displayEditPost.toggle()
                } label: {
                        Text("Edit")
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .lineLimit(1)
                            .font(.callout)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10.0)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                .frame(width: 60)
                .sheet(isPresented: $displayEditPost) {
                    EditPostView(existinPost: post)
                 }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .background(.white)
        .cornerRadius(15.0)
        .shadow(color: .black, radius: 2, x: 5, y: 10)
    }
}

struct PostView_Previews: PreviewProvider {
    static var post = Post(post: nil)
    static var previews: some View {
        PostView(post: post)
    }
}
