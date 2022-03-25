//
//  MKCheckBoxOptions.swift
//


import Foundation
import UIKit

public struct MKCheckBoxOptions {
    public var style: MKCheckBoxTypes = .medium
    public var text: String? = nil
    public var isEnabled: Bool = true
    public var textColor: Colors = .text_primary
    public var isOn: Bool = false
    
    public init(
        style: MKCheckBoxTypes = .medium,
        text: String? = nil,
        isEnabled: Bool = true,
        textColor: Colors = .text_primary,
        isOn: Bool = false
    ) {
        self.style = style
        self.text = text
        self.isEnabled = isEnabled
        self.textColor = textColor
        self.isOn = isOn
    }
}

extension MKCheckBoxOptions: Hashable, Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.style == rhs.style
        && lhs.text == rhs.text
        && lhs.isEnabled == rhs.isEnabled
        && lhs.textColor == rhs.textColor
        && lhs.isOn == rhs.isOn
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(style)
        hasher.combine(text)
        hasher.combine(isEnabled)
        hasher.combine(textColor)
        hasher.combine(isOn)
    }
    
    
}

