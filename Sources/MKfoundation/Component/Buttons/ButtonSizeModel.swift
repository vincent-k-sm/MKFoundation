//
//  ButtonSizeModel.swift
//


import Foundation

public struct ButtonSizeModel {
    var height: CGFloat
}

public enum ButtonSize: CaseIterable {
    case medium
    case small
    
    var style: ButtonSizeModel {
        switch self {
            case .medium:
                let model = ButtonSizeModel(height: 48.0)
                return model

            case .small:
                let model = ButtonSizeModel(height: 44.0)
                return model
                
        }
    }
}
