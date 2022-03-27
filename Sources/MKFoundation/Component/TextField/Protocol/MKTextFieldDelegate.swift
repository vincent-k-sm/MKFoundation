//
//  MKTextFieldDelegate.swift
//


import Foundation
@objc public protocol MKTextFieldDelegate: AnyObject {
    
    /// override Textfield
    @objc optional func textFieldShouldReturn(_ textField: MKTextField) -> Bool
    @objc optional func textFieldShouldClear(_ textField: MKTextField) -> Bool
    
    /// An textfield did count limitted
    /// - Parameter textField: The MKTextField that textfield was called in
    /// - Parameter status: textfield status - TextfieldStatus
    /// - important : Trigger Only Limit Count is Not 0
    @objc optional func textFieldLimitted(_ textField: MKTextField, limitted: Bool)
    
    /// An textfield did change Status
    /// - Parameter textField: The MKTextField that textfield was called in
    /// - Parameter status: textfield status - TextfieldStatus
    @objc optional func textFieldStatusDidChange(_ textField: MKTextField, status: TextFieldStatus)
    
    /// An textfield did change Text
    /// - Parameter textField: The MKTextField that textfield was called in
    /// - Parameter text: textfield text
    @objc optional func textFieldTextDidChange(_ textField: MKTextField, text: String)
    
    /// An textfield DidBeginEditing
    /// - Parameter textField: The MKTextField that textfield was called in
    @objc optional func textFieldTextDidBeginEditing(_ textField: MKTextField)
    
    /// An textfield textFieldTextDidEndEditing
    /// - Parameter textField: The MKTextField that textfield was called in
    @objc optional func textFieldTextDidEndEditing(_ textField: MKTextField)
}
