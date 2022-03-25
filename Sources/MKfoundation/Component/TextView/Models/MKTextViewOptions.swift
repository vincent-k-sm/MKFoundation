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
///   - leadingIcon : 좌측 이미지 심볼을 적용합니다  이미지가 있는 경우 레이아웃이 변경됩니다
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
