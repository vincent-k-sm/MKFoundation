//
//  MKTextFieldOptions.swift
//


import Foundation
import UIKit

/// 텍스트 필드를 구성하는 값을 적용합니다
/// - Parameters:
///   - placeHolder: placeholer text
///   - limitCount: 최대 글자 수
///   - autoLimitCountErrorMessage: 최대 글자수 도달 시 해당 메시지로 에러가 설정됩니다
///   - title: 텍스트 필드 제목 영역 입니다 적용 시 최대 높이가 변경됩니다
///   - helperText: 하단 설명 영역입니다 적용 시 최대 높이가 변경됩니다
///   - counter: 상단 카운트 설정 여부입니다 적용 시 최대 높이가 변경됩니다
///   - leadingIcon : 좌측 이미지 심볼을 적용합니다  이미지가 있는 경우 레이아웃이 변경됩니다
public struct MKTextFieldOptions {
    public var inputType: TextFieldTypes            = .outLine
    public var placeHolder: String                  = ""
    public var limitCount: Int                      = 0
    public var autoLimitCountErrorMessage: String?  = nil
    public var title: String?                       = nil
    public var helperText: String?                  = nil
    public var counter: Bool                        = false
    public var leadingIcon: UIImage?                = nil
    
    public init() { }
    
    public init(
        inputType: TextFieldTypes = .outLine,
        placeHolder: String = "",
        limitCount: Int = 0,
        autoLimitCountErrorMessage: String? = nil,
        title: String? = nil,
        helperText: String? = nil,
        leadingIcon: UIImage? = nil,
        counter: Bool = false
    ) {
        self.inputType                  = inputType
        self.placeHolder                = placeHolder
        self.limitCount                 = limitCount
        self.autoLimitCountErrorMessage = autoLimitCountErrorMessage
        self.title                      = title
        self.helperText                 = helperText
        self.counter                    = counter
        self.leadingIcon                = leadingIcon
    }
    
}


extension MKTextFieldOptions: Hashable, Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.inputType == rhs.inputType
        && lhs.placeHolder == rhs.placeHolder
        && lhs.limitCount == rhs.limitCount
        && lhs.autoLimitCountErrorMessage == rhs.autoLimitCountErrorMessage
        && lhs.title == rhs.title
        && lhs.helperText == rhs.helperText
        && lhs.counter == rhs.counter
        && lhs.leadingIcon == rhs.leadingIcon
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(inputType)
        hasher.combine(placeHolder)
        hasher.combine(limitCount)
        hasher.combine(autoLimitCountErrorMessage)
        hasher.combine(title)
        hasher.combine(helperText)
        hasher.combine(counter)
        hasher.combine(leadingIcon)
    }
}
