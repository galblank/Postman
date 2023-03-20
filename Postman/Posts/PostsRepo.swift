//
//  PostsRepo.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import Foundation
import Alamofire

class PostsRepo: ObservableObject {
    @Published var posts = [Post]()

    func getPostsFor(for userId: Int) {
        Helpers.sharedInstance.showNewActivity()
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else { return }
        AF.request(url, method: .get).responseJSON { [weak self] response in
            Helpers.sharedInstance.hideNewActivity()
            guard let sSelf = self else { return }
            switch response.result {
            case .success(let value):
                debugPrint(value)
                if let returnedPosts = response.value as? [[String: Any]] {
                    for jsonPost in returnedPosts {
                        let newPost = Post(post: jsonPost)
                        sSelf.posts.append(newPost)
                    }
                }
                break
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
}
