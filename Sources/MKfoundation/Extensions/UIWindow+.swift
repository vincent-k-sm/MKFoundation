//
//  UIWindow+.swift
//


import Foundation
import UIKit

public extension UIWindow {
    static var key: UIWindow? {
        
        if #available(iOS 13, *) {
            if #available(iOS 15, *) {
                return UIApplication.shared.connectedScenes
                // Keep only active scenes, onscreen and visible to the user
                    .filter { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
                // Keep only the first `UIWindowScene`
                    .first(where: { $0 is UIWindowScene })
                // Get its associated windows
                    .flatMap({ $0 as? UIWindowScene })?.windows
                // Finally, keep only the key window
                    .first(where: \.isKeyWindow)
            }
            else {
                return UIApplication.shared.windows.first { $0.isKeyWindow }
            }
            
        }
        else {
            return UIApplication.shared.keyWindow
        }
        
    }
}
