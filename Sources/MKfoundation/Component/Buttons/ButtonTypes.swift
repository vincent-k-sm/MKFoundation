//
//  ButtonTypes.swift
//


import Foundation

public enum ButtonTypes: CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case pink
    case purple
    case dark
    case primary
    case white
    case grey
}

public extension ButtonTypes {
    var style: ButtonModel {
        switch self {
        case .primary:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .purple500,
                highlightColor: .purple700,
                disableColor: .grey200
            )
            return model
        case .white:
            let model = ButtonModel(
                defaultTitleColor: .black,
                disableTitleColor: .black_disabled,
                defaultColor: .white,
                highlightColor: .white_elevated,
                disableColor: .white_disabled
            )
            return model
        case .dark:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .black,
                highlightColor: .grey900,
                disableColor: .grey200
            )
            return model
            
        case .purple:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .purple500,
                highlightColor: .purple700,
                disableColor: .grey500
            )
            return model
        case .red:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .red,
                highlightColor: .red,
                disableColor: .grey500
            )
            return model
        case .orange:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .orange,
                highlightColor: .orange,
                disableColor: .grey500
            )
            return model
        case .yellow:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .yellow,
                highlightColor: .yellow,
                disableColor: .grey500
            )
            return model
        case .green:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .green,
                highlightColor: .green,
                disableColor: .grey500
            )
            return model
        case .blue:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .blue_primary,
                highlightColor: .blue030,
                disableColor: .grey500
            )
            return model
        case .pink:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .pink,
                highlightColor: .pink,
                disableColor: .grey500
            )
            return model
                
        case .grey:
            let model = ButtonModel(
                defaultTitleColor: .white,
                disableTitleColor: .white,
                defaultColor: .grey600,
                highlightColor: .grey700,
                disableColor: .grey900
            )
            return model
        }
    }
}

