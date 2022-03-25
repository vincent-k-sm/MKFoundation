//
//  ExampleListTypes.swift
//


import Foundation

enum FoundationTypes: CaseIterable {
    case buttons
    case selectBox
    case textField
}

extension FoundationTypes {
    var title: String {
        switch self {
            case .buttons:
                return "버튼"
                
            case .selectBox:
                return "셀렉트 박스"
                
            case .textField:
                return "텍스트 필드"
        }
    }
}
