//
//  UIButton+.swift
//

import UIKit

public extension UIButton {
    /// [MKFoundation]
    /// 버튼 배경 색 설정
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: state)
    }

    /// [MKFoundation]
    /// 버튼에 들어가는 이미지와 타이틀 간 간격 조정
    func alignTextBelow(spacing: CGFloat = 2.0) {
        guard let image = self.imageView?.image else {
            return
        }
        
        guard let titleLabel = self.titleLabel else {
            return
        }
        
        guard let titleText = titleLabel.text else {
            return
        }
        
        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])
        
        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}


public extension UIButton {
    /// [MKFoundation]
    /// set Button Layout으로 지정 한 Button에 대해 Title만 갱신할 수 있는 기능
    func updateTitleText(
        text: String,
        status: [UIControl.State] = [.normal, .selected, .disabled, .highlighted]
    ) {
        status.forEach { state in
            if let currentAttrString = self.attributedTitle(for: state) {
                let currentAttrs = currentAttrString.attributes
                let attributeString = NSMutableAttributedString(string: text)
                attributeString.addAttributes(currentAttrs, range: NSRange(location: 0, length: attributeString.length))
                self.setAttributedTitle(attributeString, for: state)
            }
        }
    }
    
    /// [MKFoundation]
    /// Button Type에 따른 레이아웃 강제 조정
    func setButtonLayout(
        title: String = "",
        size: ButtonSize,
        primaryType: ButtonTypes,
        outline: Bool = false
    ) {
        var titleText = title
        if title.isEmpty {
            titleText = " "
        }
        
        let buttonHeight = size.style.height
        let defaultTitleColor: Colors = primaryType.style.defaultTitleColor
        let disableTitleColor: Colors = primaryType.style.disableTitleColor
        let defaultColor: Colors = primaryType.style.defaultColor
        let highlightColor: Colors = primaryType.style.highlightColor
        let disableColor: Colors = primaryType.style.disableColor
        
        //        let isOutlined: Bool = primaryType == .outLined
        
        self.setTitle(text: titleText, color: defaultTitleColor, state: [.normal, .highlighted])
        
        self.setTitle(text: titleText, color: disableTitleColor, state: [.disabled])
        
        /// background
        // normal
        self.setBackgroundColor(UIColor.setColorSet(defaultColor), for: .normal)
        
        // highlight
        self.setBackgroundColor(UIColor.setColorSet(highlightColor), for: .highlighted)
        
        // disable
        self.setBackgroundColor(UIColor.setColorSet(disableColor), for: .disabled)
        
        if outline {
            
            self.toCornerRound(corners: [.allCorners],
                               radius: 8.0,
                               borderColor: UIColor.setColorSet(ButtonAppearance.borderColor),
                               backgroundColor: UIColor.setColorSet(defaultColor),
                               borderWidth: 1.0)
            
        }
        else {
            self.toCornerRound(radius: 8.0)
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let heightConst = self.constraints.filter({ $0.firstAttribute == .height }).first {
            heightConst.constant = buttonHeight
        }
        else {
            self.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        }
    }
    
}

public extension UIButton {
    
    /// [MKFoundation]
    /// 버튼 타이틀 지정
    func setTitle(text: String,
                  color: Colors,
                  state: [UIControl.State] = [.normal, .highlighted, .disabled],
                  alpha: CGFloat = 1.0) {
        
        for i in state {
            let attributeString = NSMutableAttributedString(string: text)
            var attr: [NSAttributedString.Key: Any] = [:]
            attr[.font] = UIFont.systemFont(ofSize: 16.0, weight: .bold)
            attr[.foregroundColor] = UIColor.setColorSet(color)
            attributeString.addAttributes(attr, range: NSRange(location: 0, length: attributeString.length))
            self.setAttributedTitle(attributeString, for: i)
            
        }
    }
}

