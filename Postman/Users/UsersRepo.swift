//
//  UsersRepo.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import Foundation
import Alamofire

class UsersRepo: ObservableObject {
    @Published var users = [User]()
    init(showDemo: Bool = false) {
        if showDemo {
            let id = 1
            let name = "Milton"
            let username = "MWaddams"
            let email = "milton@initech.com"
            let address = ["street": "My street", "suite": "Apt 100", "city": "New York", "zipcode": "09002"]
            let phone = "555-555-4444"
            let website = "www.initech.com"
            let company = ["name": "Initech", "catchPhrase": "I wouldn't say i've been missing it Bob...", "bs": "Is this good for the company"]
            let user = User(id: id, name: name, username: username, email: email, address: address, phone: phone, website: website, company: company)
            users.append(user)
            return
        }
        Helpers.sharedInstance.showNewActivity()
        getUsers()
    }
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        AF.request(url, method: .get).responseJSON { [weak self] response in
            Helpers.sharedInstance.hideNewActivity()
            guard let sSelf = self else { return }
            switch response.result {
            case .success(let value):
                debugPrint(value)
                if let returnedUsers = response.value as? [[String: Any]] {
                    for jsonuser in returnedUsers {
                        let user = User(data: jsonuser)
                        sSelf.users.append(user)
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
