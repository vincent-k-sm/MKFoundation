//
//  TextFieldStatus.swift
//


import Foundation

@objc public enum TextViewStatus: Int, CaseIterable {
    case normal // inActivate 인풋이 채워지지 않은 상태
    case activate // 인풋이 채워진 상태
    case error
    case disabled
    
    
    var outLine: Colors {
        switch self {
            case .normal:
                return .grey500

            case .activate:
                return .purple500

            case .error:
                return .red

            case .disabled:
                return .grey500
        }
    }
    
    var fill: TextViewStatusModel {
        switch self {
                
            case .normal:
                return TextViewStatusModel(outline: .grey600, background: .textfield_bg)

            case .activate:
                return TextViewStatusModel(outline: .purple500, background: .textfield_bg)

            case .error:
                return TextViewStatusModel(outline: .grey600, background: .red)

            case .disabled:
                return TextViewStatusModel(outline: .grey600, background: .textfield_bg)
        }
    }
    
}
