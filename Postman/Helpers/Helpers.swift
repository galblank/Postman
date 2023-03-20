//
//  Helpers.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import Foundation
import SwiftUI

public typealias CompletionBlock = ((Bool)  -> Swift.Void)

class Helpers: NSObject {

    var activityVC: UIHostingController<ActivityView>?
    var newActivityView = ActivityView()
    var activityData = ActivityModel(text: "",
                                     progress: 0.0,
                                     showProgress: false)

    // Singleton object
    static let sharedInstance = Helpers()

    // we must have private initiatlizer to prevent the ability to initialize
    // singleton as non-singelton
    private override init() {
        super.init()
    }

    func showNewActivity(withProgress: Bool = false, text: String = "Please wait...") {
        activityData.text = text
        activityData.showProgressBar = withProgress
        guard activityData.displayState == .hidden else {
            return
        }
        activityData.displayState = .shown
        DispatchQueue.main.async { [weak self] in
            guard let sSelf = self,
                    let topVC = UIApplication.topViewController() else { return }
            sSelf.activityData.progress = 0.0
            sSelf.activityData.text = text
            sSelf.newActivityView = ActivityView(activityData: sSelf.activityData)
            if let actVC = sSelf.activityVC {
                actVC.rootView = sSelf.newActivityView
            } else {
                sSelf.activityVC = UIHostingController(rootView: sSelf.newActivityView)
                sSelf.activityVC?.view.backgroundColor = .clear
            }
            topVC.addChildVC(sSelf.activityVC)
        }
    }

    func hideNewActivity(with completion: CompletionBlock? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard self?.activityData.displayState == .shown,
                    let topVC = UIApplication.topViewController() else {
                completion?(true)
                return
            }
            self?.activityData.displayState = .hidden
            topVC.removeChildVC(self?.activityVC)
            completion?(true)
        }
    }
}


