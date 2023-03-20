//
//  UserProfileImage.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//
import SwiftUI
import Alamofire
import AlamofireImage

class UserProfileImage: ObservableObject {

    @Published var profileImage:UIImage?

    init() {
        profileImage = UIImage(named: "ic_profile")
    }

    init(fromUrl: String) {
        loadProfileImage(fromUrl: fromUrl)
    }

    func loadProfileImage(fromUrl: String) {
        debugPrint("loadProfileImage...fromUrl...\(fromUrl)")
        if fromUrl.isValidURL {
            AF.request(fromUrl).responseImage { [weak self] response in
                guard let sSelf = self else { return }
                if case .success(let image) = response.result {
                    DispatchQueue.main.async {
                        debugPrint("loadProfileImage...image...\(image)")
                        sSelf.profileImage = image
                    }
                } else {
                    DispatchQueue.main.async {
                        sSelf.profileImage = UIImage(named: "ic_profile")
                    }

                }
            }
        } else {
            profileImage = UIImage(named: "ic_profile")
        }
    }
}
