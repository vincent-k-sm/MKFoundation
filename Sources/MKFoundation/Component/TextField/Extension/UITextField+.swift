//
//  UITextField+.swift
//


import Foundation
import UIKit

public extension UITextField {
    func setPlaceholderText(text: String, isEnable: Bool = true) {
        if isEnable {
            self.attributedPlaceholder = UIFont.makeAttributeString(ofSize: 16, color: .text_secondary, text: text)
        }
        else {
            self.attributedPlaceholder = UIFont.makeAttributeString(ofSize: 16, color: .text_disabled, text: text)
        }
        
        self.setFontWithText(text: "", isEnable: isEnable)
    }
    
    private func setFontWithText(text: String, isEnable: Bool = true) {
        var attr: [NSAttributedString.Key: Any] = [:]
        if isEnable {
            attr = UIFont.makeAttributes(ofSize: 16, color: .text_primary)
        }
        else {
            attr = UIFont.makeAttributes(ofSize: 16, color: .text_secondary)
        }
        
        
        // textInput Container 에서 margin이 생기는 현상 대응 (커스텀 폰트만 해당)
        attr.removeValue(forKey: .baselineOffset)
        attr.removeValue(forKey: .paragraphStyle)
        
        self.defaultTextAttributes = attr
        self.typingAttributes = attr
    
    }
}

