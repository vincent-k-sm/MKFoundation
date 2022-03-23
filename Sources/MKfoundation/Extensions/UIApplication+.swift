//
//  UIApplication+.swift
//


import Foundation
import UIKit

public extension UIApplication {

    class func topViewController(base: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)

        }
        else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)

        }
        else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        }
        catch {
            SystemUtils.shared.print("Failed to delete launch screen cache: \(error)", self)
        }
    }

}
