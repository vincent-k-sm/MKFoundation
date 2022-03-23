//
//  UIColor+.swift
//


import Foundation
import UIKit

public extension UIColor {
    /// [MKFoundation]
    /// darkMode 와 매칭되는 색상 설정
    static func setColorSet(_ colorRawValue: Colors) -> UIColor {
        var color: UIColor = .black
        color = UIColor(named: colorRawValue.rawValue, in: Bundle.module, compatibleWith: nil)!
        return color
    }
}
