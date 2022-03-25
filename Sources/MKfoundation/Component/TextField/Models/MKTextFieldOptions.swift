//
//  MKTextFieldOptions.swift
//


import Foundation
import UIKit

/// 텍스트 필드를 구성하는 값을 적용합니다
/// - Parameters:
///   - placeHolder: placeholer text
///   - limitCount: 최대 글자 수
///   - autoLimitCountErrorMessage: 최대 글자수 도달 시 자동으로 에러 출력
///   - title: 텍스트 필드 제목 영역 입니다 적용 시 최대 높이가 변경됩니다
///   - helperText: 하단 설명 영역입니다 적용 시 최대 높이가 변경됩니다
///   - counter: 상단 카운트 설정 여부입니다 적용 시 최대 높이가 변경됩니다
///   - leadingIcon : 좌측 이미지 심볼을 적용합니다  이미지가 있는 경우 레이아웃이 변경됩니다
public struct MKTextFieldOptions {
    var inputType: TextFieldTypes            = .outLine
    var placeHolder: String                  = ""
    var limitCount: Int                      = 0
    var autoLimitCountErrorMessage: String?  = nil
    var title: String?                       = nil
    var helperText: String?                  = nil
    var counter: Bool                        = false
    var leadingIcon: UIImage?                = nil
    
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
