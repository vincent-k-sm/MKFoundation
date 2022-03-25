//
//  TextFieldStatus.swift
//


import Foundation

@objc public enum TextFieldStatus: Int, CaseIterable {
    case normal // inActivate 인풋이 채워지지 않은 상태
    case focused
    case activate // 인풋이 채워진 상태
    case error
    case disabled
    
    
    var outLine: Colors {
        switch self {
            case .normal, .activate:
                return .grey500

            case .focused:
                return .purple500

            case .error:
                return .red

            case .disabled:
                return .grey500
        }
    }
    
    var fill: SelectBoxStatusModel {
        switch self {
                
            case .normal:
                return SelectBoxStatusModel(outline: .grey600, background: .grey300)

            case .focused:
                return SelectBoxStatusModel(outline: .grey600, background: .grey300)

            case .activate:
                return SelectBoxStatusModel(outline: .purple500, background: .grey300)

            case .error:
                return SelectBoxStatusModel(outline: .grey600, background: .red)

            case .disabled:
                return SelectBoxStatusModel(outline: .grey600, background: .grey500)
        }
    }
    
}
