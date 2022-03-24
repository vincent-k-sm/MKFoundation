//
//  UIFont+.swift
//


import Foundation
import UIKit

public extension UIFont {

    /// 파운데이션 내 Typo와 AttributedString을 생성하는 클래스입니다
    /// - Parameters:
    ///   - typo: headLine1, headLine2 등 Figma에서 정의된 항목을 설정합니다
    ///   - color: HexColor 를 설정합니다
    ///   - textAlignment: aliign을 설정합니다 / default : .left
    ///   - text: 적용할 Text를 설정합니다
    ///   - alpha: 투명도를 설정합니다 / default : 1.0
    /// - Returns: NSMutableAttributedString
    static func makeAttributeString(
        ofSize fontSize: CGFloat,
        color: Colors,
        textAlignment: NSTextAlignment = .left,
        text: String,
        alpha: CGFloat = 1.0,
        lineBreakMode: Bool = false
    ) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        
        let attr = self.makeAttributes(ofSize: fontSize, color: color, textAlignment: textAlignment, lineBreakMode: lineBreakMode)

        attributeString.addAttributes(attr, range: NSRange(location: 0, length: attributeString.length))
        
        return attributeString
    }
    
    /// 파운데이션 내 Typo와 Attributes을 생성하는 클래스입니다
    /// - Parameters:
    ///   - typo: headLine1, headLine2 등 Figma에서 정의된 항목을 설정합니다
    ///   - color: HexColor 를 설정합니다
    ///   - textAlignment: aliign을 설정합니다 / default : .left
    ///   - text: 적용할 Text를 설정합니다
    ///   - alpha: 투명도를 설정합니다 / default : 1.0
    /// - Returns: [NSAttributedString.Key: Any]
    static func makeAttributes(
        ofSize fontSize: CGFloat,
        color: Colors,
        textAlignment: NSTextAlignment = .left,
        alpha: CGFloat = 1.0,
        lineBreakMode: Bool = false
    ) -> [NSAttributedString.Key: Any] {
        
        let font = UIFont.systemFont(ofSize: fontSize)
        let style = NSMutableParagraphStyle()
        if lineBreakMode {
            style.lineBreakMode = .byTruncatingTail
        }
        
        // TODO: Need Develop & Mornitoring

        style.alignment = textAlignment
        
        var attr: [NSAttributedString.Key: Any] = [:]
        attr[.font] = font
        attr[.foregroundColor] = UIColor.setColorSet(color).withAlphaComponent(alpha)
        
        attr[.paragraphStyle] = style
        return attr
    }
}
