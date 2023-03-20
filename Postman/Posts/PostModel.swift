//
//  PostModel.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    let post: [String: Any]?

    var title: String {
        get {
            if let thisTitle = post?["title"] as? String {
                return thisTitle
            } else {
                return "Title"
            }
        }
    }

    var body: String {
        get {
            if let thisTitle = post?["body"] as? String {
                return thisTitle
            } else {
                return "This is where post body is gonna go"
            }
        }
    }
}
