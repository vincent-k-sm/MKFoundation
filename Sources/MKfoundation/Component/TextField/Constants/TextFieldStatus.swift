//
//  TextFieldStatus.swift
//


import Foundation

@objc public enum TextFieldStatus: Int, CaseIterable {
    case normal // inActivate 인풋이 채워지지 않은 상태
    case activate // 인풋이 채워진 상태
    case error
    case disabled
    
    public var info: String {
        switch self {
            case .normal:
                return "Normal"
            case .activate:
                return "Active"
            case .error:
                return "Error"
            case .disabled:
                return "disabled"
        }
    }
    
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
    
    var fill: TextFieldStatusModel {
        switch self {
                
            case .normal:
                return TextFieldStatusModel(outline: .grey600, background: .textfield_bg)

            case .activate:
                return TextFieldStatusModel(outline: .purple500, background: .textfield_bg)

            case .error:
                return TextFieldStatusModel(outline: .grey600, background: .red)

            case .disabled:
                return TextFieldStatusModel(outline: .grey600, background: .textfield_bg)
        }
    }
    
}
