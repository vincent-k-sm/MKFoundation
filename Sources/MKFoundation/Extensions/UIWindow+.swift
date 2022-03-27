//
//  UIWindow+.swift
//


import Foundation
import UIKit

public extension UIWindow {
    
    /// [MKFoundation]
    static var key: UIWindow? {
        
        if #available(iOS 13, *) {
            var window = UIApplication.shared.windows.first { $0.isKeyWindow }
            if #available(iOS 15, *) {
                if let sceneWindow = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene})
                    .flatMap({ $0.windows })
                    .first(where: { $0.isKeyWindow }) {
                    window = sceneWindow
                }
                
            }

            return window
            
        }
        else {
            return UIApplication.shared.keyWindow
        }
        
    }
}
