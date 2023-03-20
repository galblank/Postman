//
//  ActivityModel.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import Foundation
import Combine

enum DisplayState: Int {
    case shown
    case hidden
}

class ActivityModel: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var text = "Please wait"
    var displayState: DisplayState = .hidden
    @Published  var showProgressBar: Bool = false
    init(text: String, progress: Double, showProgress: Bool) {
        self.text = text
        self.progress = progress
        self.showProgressBar = showProgress
    }
}
