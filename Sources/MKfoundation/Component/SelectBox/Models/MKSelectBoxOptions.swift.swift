//
//  MKSelectBoxOptions.swift.swift
//


import Foundation
import UIKit

/// 셀렉트 박스 를 구성하는 값을 적용합니다
/// - Parameters:
///   - placeHolder: placeholer text
///   - title: 텍스트 필드 제목 영역 입니다 적용 시 최대 높이가 변경됩니다
///   - helperText: 하단 설명 영역입니다 적용 시 최대 높이가 변경됩니다

public struct MKSelectBoxOptions {
    public var inputType: SelectBoxTypes = .outLine
    public var placeHolder: String       = ""
    public var title: String?            = nil
    public var helperText: String?       = nil
    
    public init() { }
    
    public init(
        inputType: SelectBoxTypes = .outLine,
        placeHolder: String       = "",
        title: String?            = nil,
        helperText: String?       = nil
        
    ) {
        self.inputType            = inputType
        self.placeHolder          = placeHolder
        self.title                = title
        self.helperText           = helperText
    }
    
}

extension MKSelectBoxOptions: Hashable, Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.inputType == rhs.inputType
        && lhs.placeHolder == rhs.placeHolder
        && lhs.title == rhs.title
        && lhs.helperText == rhs.helperText
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(inputType)
        hasher.combine(placeHolder)
        hasher.combine(title)
        hasher.combine(helperText)
    }
}
