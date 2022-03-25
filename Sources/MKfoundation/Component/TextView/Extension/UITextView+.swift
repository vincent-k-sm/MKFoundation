//
//  UITextView.swift
//


import Foundation
import UIKit

public extension UITextView {

    private class PlaceholderLabel: UILabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap({ $0 as? PlaceholderLabel }).first {
            return label
        }
        else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            addSubview(label)
            return label
        }
    }

    @IBInspectable
    var placeholder: String {
        get {
            return subviews.compactMap({ $0 as? PlaceholderLabel }).first?.text ?? ""
        }

    }
    var placeHolderAttributeString: NSAttributedString? {
        get {
            return subviews.compactMap({ $0 as? PlaceholderLabel }).first?.attributedText
        }
    }
    
    func setPlaceholderText(text: String, isEnable: Bool = true) {
        let placeholderLabel = self.placeholderLabel
        var attrString: NSMutableAttributedString!
        if isEnable {
            
            attrString = UIFont.makeAttributeString(ofSize: 16, color: .text_secondary, text: text)
        }
        else {
            attrString = UIFont.makeAttributeString(ofSize: 16, color: .text_disabled, text: text)
        }

        placeholderLabel.attributedText = attrString
        
        placeholderLabel.numberOfLines = 1

        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textContainer.lineFragmentPadding).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -textContainer.lineFragmentPadding).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: textContainerInset.top).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -textContainerInset.bottom).isActive = true

        textStorage.delegate = self
        self.setFontWithText(text: text, isEnable: isEnable)
        self.setNeedsLayout()
        self.setNeedsUpdateConstraints()
    }
    
    func setFontWithText(text: String, isEnable: Bool = true) {
        if isEnable {
            self.typingAttributes = UIFont.makeAttributes(ofSize: 16, color: .text_primary)
        }
        else {
            self.typingAttributes = UIFont.makeAttributes(ofSize: 16, color: .text_secondary)
        }
        
    }
    
}

extension UITextView: NSTextStorageDelegate {

    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

}

extension UITextView {

    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }

}

