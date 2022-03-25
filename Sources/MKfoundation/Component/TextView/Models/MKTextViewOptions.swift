//
//  MKTextViewOptions.swift
//


import Foundation
import UIKit

/// 텍스트 필드를 구성하는 값을 적용합니다
/// - Parameters:
///   - textViewHeight: Textview 높이를 고정하는 경우 사용됩니다
///   - placeHolder: placeholer text
///   - limitCount: 최대 글자 수
///   - autoLimitCountErrorMessage: 최대 글자수 도달 시 자동으로 에러 출력
///   - title: 텍스트 필드 제목 영역 입니다 적용 시 최대 높이가 변경됩니다
///   - helperText: 하단 설명 영역입니다 적용 시 최대 높이가 변경됩니다
///   - counter: 상단 카운트 설정 여부입니다 적용 시 최대 높이가 변경됩니다
///   - doneAccessory : 키보드의 닫기 버튼을 추가합니다
///   - clearAccessory : 텍스트 뷰를 클리어하는 버튼이 사용됩니다
public struct MKTextViewOptions {
    public var textViewHeight: CGFloat              = 0.0
    public var inputType: TextViewTypes             = .outLine
    public var placeHolder: String                  = ""
    public var limitCount: Int                      = 0
    public var autoLimitCountErrorMessage: String?  = nil
    public var title: String?                       = nil
    public var helperText: String?                  = nil
    public var counter: Bool                        = false
    public var doneAccessory: Bool                  = false
    public var clearAccessory: Bool                 = false
    
    public init() { }
    
    public init(
        textViewHeight: CGFloat = 0.0,
        inputType: TextViewTypes = .outLine,
        placeHolder: String = "",
        limitCount: Int = 0,
        autoLimitCountErrorMessage: String? = nil,
        title: String? = nil,
        helperText: String? = nil,
        counter: Bool = false,
        doneAccessory: Bool = false,
        clearAccessory: Bool = false
    ) {
        self.textViewHeight             = textViewHeight
        self.inputType                  = inputType
        self.placeHolder                = placeHolder
        self.limitCount                 = limitCount
        self.autoLimitCountErrorMessage = autoLimitCountErrorMessage
        self.title                      = title
        self.helperText                 = helperText
        self.counter                    = counter
        self.doneAccessory              = doneAccessory
        self.clearAccessory             = clearAccessory
    }
    
}

extension MKTextViewOptions: Hashable, Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.textViewHeight         == rhs.textViewHeight
        && lhs.inputType                  == rhs.inputType
        && lhs.placeHolder                == rhs.placeHolder
        && lhs.limitCount                 == rhs.limitCount
        && lhs.autoLimitCountErrorMessage == rhs.autoLimitCountErrorMessage
        && lhs.title                      == rhs.title
        && lhs.helperText                 == rhs.helperText
        && lhs.counter                    == rhs.counter
        && lhs.doneAccessory              == rhs.doneAccessory
        && lhs.clearAccessory             == rhs.clearAccessory
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(textViewHeight)
        hasher.combine(inputType)
        hasher.combine(placeHolder)
        hasher.combine(limitCount)
        hasher.combine(autoLimitCountErrorMessage)
        hasher.combine(title)
        hasher.combine(helperText)
        hasher.combine(counter)
        hasher.combine(doneAccessory)
        hasher.combine(clearAccessory)
    }
}
