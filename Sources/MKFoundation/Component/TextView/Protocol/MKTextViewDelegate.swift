//
//  MKTextViewDelegate.swift
//


import Foundation
@objc public protocol MKTextViewDelegate: AnyObject {
    /// An textView did count limitted
    /// - Parameter textView: The MKTextView that textView was called in
    /// - Parameter status: textView status - textViewStatus
    /// - important : Trigger Only Limit Count is Not 0
    @objc optional func textViewLimitted(_ textView: MKTextView, limitted: Bool)
    
    /// An textView did change Status
    /// - Parameter textView: The MKTextView that textView was called in
    /// - Parameter status: textView status - textViewStatus
    @objc optional func textViewStatusDidChange(_ textView: MKTextView, status: TextViewStatus)
    
    /// An textView did change Text
    /// - Parameter textView: The MKTextView that textView was called in
    /// - Parameter text: textView text
    @objc optional func textViewTextDidChange(_ textView: MKTextView, text: String)
    
    /// An textView DidBeginEditing
    /// - Parameter textView: The MKTextView that textView was called in
    @objc optional func textViewTextDidBeginEditing(_ textView: MKTextView)
    
    /// An textView textViewTextDidEndEditing
    /// - Parameter textView: The MKTextView that textView was called in
    @objc optional func textViewTextDidEndEditing(_ textView: MKTextView)
}
