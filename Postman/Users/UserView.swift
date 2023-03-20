//
//  UserView.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//
import SwiftUI

struct UserView: View {
    var user: User?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(user?.username ?? "Name")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                        .font(.headline)
                    Text(user?.getAddress() ?? "Full address here")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                        .font(.subheadline)
                }
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        .background(.white)
        .cornerRadius(15.0)
        .shadow(color: .black, radius: 2, x: 5, y: 10)
    }
}

struct UserView_Previews: PreviewProvider {
    static var user = User(id: 1, name: "Milton", username: "Waddams", email: "milton@initech.com", address: ["street": "Main"], phone: "34535", website: "ewrwer.ww.com", company: ["name": "Initech"])
    static var previews: some View {
        UserView(user: user)
    }
}
