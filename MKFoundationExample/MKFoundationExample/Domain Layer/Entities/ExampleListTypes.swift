//
//  ExampleListTypes.swift
//


import Foundation

enum FoundationTypes: CaseIterable {
    case buttons
}

extension FoundationTypes {
    var title: String {
        switch self {
            case .buttons:
                return "버튼"
        }
    }
}
