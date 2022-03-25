//
//  MKTextViewCore.swift
//


import Foundation
import UIKit

public class MKTextViewCore: UITextView {
    
    var placeHolderText = "" {
        didSet {
            self.setFont()
        }
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        self.backgroundColor = .clear
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    public override var isUserInteractionEnabled: Bool {
        didSet {
            self.setFont()
        }
    }
    
}

extension MKTextViewCore {
    fileprivate func setupUI() {
        
    }
    
    private func setFont() {
        self.setPlaceholderText(text: self.placeHolderText, isEnable: self.isUserInteractionEnabled)
    }
    
}
