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
///   - input : 셀렉트 박스 안에 들어갈 인풋입니다 (별도 설정이 가능합니다)

public struct MKSelectBoxOptions {
    var inputType: SelectBoxTypes = .outLine
    var placeHolder: String       = ""
    var title: String?            = nil
    var helperText: String?       = nil
    var input: String?            = nil
    
    public init() { }
    
    public init(
        inputType: SelectBoxTypes = .outLine,
        placeHolder: String       = "",
        title: String?            = nil,
        helperText: String?       = nil,
        input: String?            = nil
        
    ) {
        self.inputType            = inputType
        self.placeHolder          = placeHolder
        self.title                = title
        self.helperText           = helperText
        self.input                = input
    }
    
}
