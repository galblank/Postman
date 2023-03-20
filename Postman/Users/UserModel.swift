//
//  UserModel.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import Foundation


struct User: Identifiable {
    let uniqueID = UUID()
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let address: [String: Any]?
    let phone: String?
    let website: String?
    let company: [String: Any]?

    init(id: Int, name: String, username: String, email: String, address: [String: Any], phone: String, website: String, company: [String: Any]) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }

    init(data: [String: Any]) {
        if let id = data["id"] as? Int {
            self.id = id
        } else {
            self.id = 1
        }

        if let name = data["name"] as? String {
            self.name = name
        } else {
            self.name = "name"
        }

        if let username = data["username"] as? String {
            self.username = username
        } else {
            self.username = "username"
        }

        if let email = data["email"] as? String {
            self.email = email
        } else {
            self.email = "email"
        }

        if let address = data["address"] as? [String: Any] {
            self.address = address
        } else {
            self.address = ["street": "Main st"]
        }

        if let phone = data["phone"] as? String {
            self.phone = phone
        } else {
            self.phone = "2342342"
        }

        if let website = data["website"] as? String {
            self.website = website
        } else {
            self.website = "sdfsdfs"
        }

        if let company = data["company"] as? [String: Any] {
            self.company = company
        } else {
            self.company = ["name": "Initech"]
        }
    }
    
    func getAddress() -> String {
       if let apt = address?["suite"] as? String,
          let street = address?["street"] as? String,
          let city = address?["city"] as? String,
          let zip = address?["zipcode"] as? String {
           let fullAddress = "\(apt) \(street), \(city), \(zip)"
           return fullAddress
       }
        return "2023 Boring, Oregon, USA"
    }
}
