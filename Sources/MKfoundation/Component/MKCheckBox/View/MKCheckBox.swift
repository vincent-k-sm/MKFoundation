//
//  MKCheckBox.swift
//


import Foundation
import UIKit

public class MKCheckBox: UIView {
    public var isOn: Bool = false {
        willSet {
            self.updateUI(isOn: newValue)
            self.statusUpdated(isOn: newValue)
        }
    }
    
    public var isEnabled: Bool {
        get {
            return self.checkBoxButton.isEnabled
        }
        set {
            self.checkBoxButton.isEnabled = newValue
        }
    }

    public var titleText: String {
        get {
            return self.titleLabel.text ?? ""
        }
        set {
            self.titleLabel.text = newValue
            self.titleLabel.isHidden = newValue.isEmpty
        }
    }
    
    private(set) var options: MKCheckBoxOptions = MKCheckBoxOptions()
    
    public weak var delegate: MKCheckBoxDelegate?
    
    lazy var symbolImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    public lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 17)
        return v
    }()
    
    lazy var checkBoxButton: UIButton = {
        let v = UIButton(type: .custom)
        return v
    }()
    
   
    public init() {
        super.init(frame: .zero)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
}

extension MKCheckBox {
    private func commonInit() {
        self.setUI()
    }
    
    fileprivate func setUI() {
        self.setLayout()
        let option = self.options
        self.titleText = option.text ?? ""
        self.isEnabled = option.isEnabled
        self.isOn = option.isOn
        self.addEvent()
    }
    
    private func setLayout() {
        self.addSubview(symbolImageView)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        let symbolImageViewConstraints = [
            symbolImageView.leftAnchor.constraint(equalTo: symbolImageView.superview!.leftAnchor, constant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 24),
            symbolImageView.widthAnchor.constraint(equalToConstant: 24),
            symbolImageView.centerYAnchor.constraint(equalTo: symbolImageView.superview!.centerYAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(symbolImageViewConstraints)
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: symbolImageView.superview!.rightAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: titleLabel.superview!.rightAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
    
        self.addSubview(checkBoxButton)
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false
        let checkBoxButtonConstraints = [
            checkBoxButton.topAnchor.constraint(equalTo: checkBoxButton.superview!.topAnchor, constant: 0),
            checkBoxButton.leftAnchor.constraint(equalTo: checkBoxButton.superview!.leftAnchor, constant: 0),
            checkBoxButton.rightAnchor.constraint(equalTo: checkBoxButton.superview!.rightAnchor, constant: 0),
            checkBoxButton.bottomAnchor.constraint(equalTo: checkBoxButton.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(checkBoxButtonConstraints)
        
        
    }
    
    private func updateUI(isOn: Bool) {
        var symbolImageString = ""
        if self.isEnabled {
            symbolImageString = isOn ? "ic_checkbox_on" : "ic_checkbox_off"
            
        }
        else {
            symbolImageString = isOn ? "ic_checkbox_on_disable" : "ic_checkbox_off_disable"
        }
        
        
        self.symbolImageView.image = UIImage(named: symbolImageString, in: Bundle.module, compatibleWith: nil)
    }
    
    private func statusUpdated(isOn: Bool) {
        self.delegate?.didChangeStatus(self, status: isOn)
    }
}


// MARK: - MKCheckBox Event
extension MKCheckBox {
    private func addEvent() {
        self.checkBoxButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        self.delegate?.didSelected(self)
        if self.isEnabled {
            self.isOn.toggle()
        }
    }
}

public extension MKCheckBox {
    func configure(option: MKCheckBoxOptions) {
        
        self.options = option
        self.setUI()
    }
}
