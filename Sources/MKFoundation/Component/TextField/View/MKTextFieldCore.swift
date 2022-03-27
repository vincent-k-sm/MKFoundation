//
//  File.swift
//


import Foundation
import UIKit

open class MKTextFieldCore: UITextField {
    
    var placeHolderText = "" {
        didSet {
            self.setFont()
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    open override var isUserInteractionEnabled: Bool {
        didSet {
            self.setFont()
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
}

extension MKTextFieldCore {
    fileprivate func setupUI() {
        self.setTextfieldOption()
    }
    
    
    private func setFont() {
        self.setPlaceholderText(text: self.placeHolderText, isEnable: self.isUserInteractionEnabled)
    }
    
    private func setTextfieldOption() {
        self.clearButtonMode = .whileEditing
    }
}
