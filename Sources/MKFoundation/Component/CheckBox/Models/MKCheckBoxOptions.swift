//
//  MKCheckBoxOptions.swift
//


import Foundation
import UIKit

/// 체크박스를 구성하는 값을 적용합니다
/// - Parameters:
///   - text : 컨텐츠 내용
///   - isEnabled : enable 여부를 설정합니다
///   - textColor : 제목 색상 (title Label에 직접 접근하여 변경할 수 있습니다)
///   - isOn: On/Off Status
public struct MKCheckBoxOptions {
    
    public var text: String?     = nil
    public var isEnabled: Bool   = true
    public var textColor: Colors = .text_primary
    public var isOn: Bool        = false
    
    public init(
        text: String?     = nil,
        isEnabled: Bool   = true,
        textColor: Colors = .text_primary,
        isOn: Bool        = false
    ) {
        self.text = text
        self.isEnabled = isEnabled
        self.textColor = textColor
        self.isOn = isOn
    }
}

extension MKCheckBoxOptions: Hashable, Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.text == rhs.text
        && lhs.isEnabled == rhs.isEnabled
        && lhs.textColor == rhs.textColor
        && lhs.isOn == rhs.isOn
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(isEnabled)
        hasher.combine(textColor)
        hasher.combine(isOn)
    }
    
    
}

