//
//  Extensions.swift
//  Postman
//
//  Created by Gal Blank on 3/19/23.
//

import Foundation
import UIKit

public extension UIApplication {
    /// Sweeter: `keyWindow` for scene-based apps
    var legacyKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return windows.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }

    /// Sweeter: Returns the currently top-most view controller.
    class func topViewController(base: UIViewController? = UIApplication.shared.legacyKeyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }

    /// Sweeter: Show `viewController` over the top-most view controller.
    class func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            topViewController()?.present(viewController, animated: animated, completion: completion)
        }
    }
}

public extension UIViewController {
    /// Add a child view controller. bottom == false
    func addChildVC(_ childVC: UIViewController?) {
        addChildVC(childVC, bottom: false)
    }

    /// Add a child view controller. bottom == true inserts at index 0
    func addChildVC(_ childVC: UIViewController?, bottom: Bool) {
        guard let childVC = childVC else { return }
        childVC.willMove(toParent: self)
        addChild(childVC)
        if bottom {
            view.insertSubview(childVC.view, at: 0)
        } else {
            view.addSubview(childVC.view)
        }
        childVC.didMove(toParent: self)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        childVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        childVC.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }

    /// Add a child view controller below a given view
    func addChildVC(_ childVC: UIViewController?, below subview: UIView?) {
        guard let childVC = childVC else { return }
        childVC.willMove(toParent: self)
        addChild(childVC)
        if let subview = subview {
            view.insertSubview(childVC.view, belowSubview: subview)
        } else {
            view.addSubview(childVC.view)
        }
        childVC.didMove(toParent: self)
    }

    /// Remove childVC from its parent
    func removeChildVC(_ childVC: UIViewController?) {
        guard let childVC = childVC, childVC.parent != nil, childVC.view.superview != nil else { return }
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
        childVC.didMove(toParent: nil)
    }
}

public extension String {
    typealias ID = Int
    var id: Int {
        return hash
    }
    /// Checks if the `String` is a valid email address (RFC 2822)
    var isValidEmail: Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
