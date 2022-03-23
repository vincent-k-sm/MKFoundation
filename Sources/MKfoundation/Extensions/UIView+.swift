//
//  UIView+.swift
//


import Foundation
import UIKit

public extension UIView {
    
    /// [MKFoundation]
    func outline(
        borderWidth: CGFloat,
        borderColor: UIColor,
        backgroundColor: UIColor = .clear,
        opacity: CGFloat = 1.0
    ) {
        self.layer.backgroundColor = backgroundColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
    }

    /// [MKFoundation]
    /// 생성 시 background color는 override 되지 않습니다
    func toCornerRound(
        corners: UIRectCorner = .allCorners,
        radius: CGFloat,
        borderColor: UIColor = .clear,
        backgroundColor: UIColor = .clear,
        borderWidth: CGFloat = 0.0
    ) {
        
        if let currentLayer = self.layer.sublayers?.filter({ $0 is CAShapeLayer }) {
            for layer in currentLayer where layer is CAShapeLayer {
                if layer.name != "ShadowLayer" {
                    layer.removeFromSuperlayer()
                }
                if layer.name == "CornerRadius" {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        if corners == .allCorners {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
            self.outline(borderWidth: borderWidth, borderColor: borderColor, backgroundColor: backgroundColor)
            self.clipsToBounds = true
        }
        else {
            
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            
            let mask = CAShapeLayer()
            mask.name = "CornerRadius"
            mask.path = path.cgPath
            self.layer.mask = mask
            
            let borderPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let borderLayer = CAShapeLayer()
            
            borderLayer.path = borderPath.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.frame = self.bounds
            self.layer.addSublayer(borderLayer)
        }
        
    }
    
    func addShadow(shadowColor: UIColor, offSet: CGSize,
                   opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat,
                   corners: UIRectCorner, fillColor: UIColor = .white,
                   borderColor: UIColor = .clear, borderWidth: CGFloat = 0.0, borderOpacity: CGFloat = 1.0) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath // 1
        shadowLayer.name = "ShadowLayer"
        shadowLayer.path = cgPath // 2
        shadowLayer.fillColor = fillColor.cgColor // 3
        shadowLayer.shadowColor = shadowColor.cgColor // 4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet // 5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.borderWidth = borderWidth
        shadowLayer.borderColor = borderColor.withAlphaComponent(borderOpacity).cgColor
        
        self.backgroundColor = .clear
        
        if let currentLayer = self.layer.sublayers?.filter({ $0 is CAShapeLayer }) {
            for layer in currentLayer where layer is CAShapeLayer {
                if layer.name == "ShadowLayer" {
                    layer.removeFromSuperlayer()
                }
                
            }
        }
        
        self.layer.insertSublayer(shadowLayer, at: 0)
        
    }
    
}
public extension UIView {
//    convenience init(withAutoLayout autoLayout: Bool) {
//        self.init()
//        translatesAutoresizingMaskIntoConstraints = !autoLayout
//    }

    var compatibleTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        else {
            return topAnchor
        }
    }

    var compatibleBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        else {
            return bottomAnchor
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }

    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
    }
}

public extension UIView {
    func makeSnapshot() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        }
        else {
            return layer.makeSnapshot()
        }
    }
}

public extension CALayer {
    func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}

public extension UIApplication {

    func getKeyWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            return windows.first { $0.isKeyWindow }
        }
        else {
            return keyWindow
        }
    }

    func makeSnapshot() -> UIImage? { return getKeyWindow()?.layer.makeSnapshot() }
}

public extension UIView {
    var globalPoint: CGPoint? {
        return self.superview?.convert(self.frame.origin, to: nil)
    }

    var globalFrame: CGRect? {
        return self.superview?.convert(self.frame, to: nil)
    }
}
