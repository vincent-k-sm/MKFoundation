//
//  MKSwitch.swift
//


import Foundation
import UIKit

public class MKSwitch: UIView {
    
    @IBInspectable public var isOn: Bool = false {
        didSet {
            if !self.isEnabled {
                return
            }
            self.updateBgColor()
            self.animationSwitcherButton(animate: true)
        }
    }
    
    @IBInspectable public var isEnabled: Bool = true {
        didSet {
            self.updateBgColor()
        }
    }
    
    lazy var button: UIButton = {
        let v = UIButton(type: .custom)
        v.backgroundColor = .white
        v.frame = CGRect(
            x: 0,
            y: 0,
            width: SwitchConstants.circleWidth,
            height: SwitchConstants.circleHeight
        )
        v.layer.shadowOffset = CGSize(width: 0, height: 0.2)
        v.layer.shadowOpacity = 0.3
        v.layer.shadowRadius = self.offCenterPosition
        v.layer.cornerRadius = SwitchConstants.circleHeight / 2
        v.layer.shadowPath = UIBezierPath(
            roundedRect: v.layer.bounds,
            cornerRadius: v.frame.height / 2
        ).cgPath
        
        return v
    }()
    
    private var buttonLeftConstraint: NSLayoutConstraint!
    public weak var delegate: SwitchDelegate?
    private var offCenterPosition: CGFloat!
    private var onCenterPosition: CGFloat!
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: SwitchConstants.viewWidth, height: SwitchConstants.viewHeight))
        commonInit()
    }
    
    public init(x: CGFloat, y: CGFloat, isOn: Bool) {
        super.init(frame: CGRect(x: x, y: y, width: SwitchConstants.viewWidth, height: SwitchConstants.viewHeight))
        self.isOn = isOn
        commonInit()
    }
    
    public override func awakeFromNib() {
        commonInit()
    }
    
    private func commonInit() {
        self.setUI()
        self.initLayout()
        self.registGesture()
        
        self.animationSwitcherButton(animate: false)
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
        button.layer.cornerRadius = button.bounds.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func switcherButtonTouch(_ sender: AnyObject) {
        if !self.isEnabled {
            return
        }
        isOn.toggle()
        animationSwitcherButton(animate: true)
        delegate?.isOnValueChange(switch: self, isOn: isOn)
    }
    
    public func setSwitch(isOn: Bool) {
        self.isOn = isOn
        delegate?.isOnValueChange(switch: self, isOn: isOn)
    }
}

// MARK: - UI
extension MKSwitch {
    private func setUI() {
        self.button = UIButton(type: .custom)
        self.addSubview(button)
        
        self.offCenterPosition = SwitchConstants.viewHeight * 0.1
        self.onCenterPosition = SwitchConstants.viewWidth - (SwitchConstants.viewHeight * 0.9)
    }
    
    private func initLayout() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: SwitchConstants.circleWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: SwitchConstants.circleHeight).isActive = true
        
        buttonLeftConstraint = button.leftAnchor.constraint(equalTo: self.leftAnchor)
        buttonLeftConstraint.isActive = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.widthAnchor.constraint(equalToConstant: SwitchConstants.viewWidth).isActive = true
        let expectHeight = SwitchConstants.viewHeight
        if let heightConst = self.constraints.filter({ $0.firstAttribute == .height }).first {
            heightConst.constant = expectHeight
        }
        else {
            self.heightAnchor.constraint(equalToConstant: expectHeight).isActive = true
        }
        
    }
}

// MARK: - Gesture
extension MKSwitch {
    private func registGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.switcherButtonTouch(_:)))
        self.addGestureRecognizer(tap)
        
        button.addTarget(self, action: #selector(switcherButtonTouch(_:)), for: UIControl.Event.touchUpInside)
    }
}

// MARK: - Event
extension MKSwitch {
    private func updateBgColor() {
        switch self.isEnabled {
            case true:
                self.backgroundColor = isOn ? SwitchConstants.enableOnBackgroundColor : SwitchConstants.enableOffBackgroundColor

            case false:
                self.backgroundColor = isOn ? SwitchConstants.disableOnBackgroundColor : SwitchConstants.disableOffBackgroundColor
        }
        
    }
    
    private func animationRotate(isOn: Bool) {
        if isOn {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = -CGFloat(Double.pi)
            rotateAnimation.toValue = 0.0
            rotateAnimation.duration = 0.45
            rotateAnimation.isCumulative = false
            self.button.layer.add(rotateAnimation, forKey: "rotate")
        }
        else {
            self.button.layer.shadowOffset = CGSize.zero
            self.button.layer.shadowOpacity = 0
            self.button.layer.shadowRadius = self.button.frame.height / 2
            self.button.layer.cornerRadius = self.button.frame.height / 2
            self.button.layer.shadowPath = nil
        }
    }
    
    private func animationSwitcherButton(animate: Bool) {
        if animate {
            UIView.animate(withDuration: SwitchConstants.animateDuration,
                           delay: 0.0,
                           options: .curveEaseInOut,
                           animations: { () -> Void in
                
                self.isOn ? self.onEvent() : self.offEvent()
                
            }, completion: { (finish: Bool) -> Void in
                self.updateBgColor()
            })
            
        }
        else {
            self.isOn ? self.onEvent() : self.offEvent()
            self.updateBgColor()
        }
    }
    
    private func onEvent() {
        self.button.isSelected = true
        self.buttonLeftConstraint.constant = self.onCenterPosition
        self.layoutIfNeeded()
    }
    
    private func offEvent() {
        self.button.isSelected = false
        self.buttonLeftConstraint.constant = self.offCenterPosition
        self.layoutIfNeeded()
        
    }
}
