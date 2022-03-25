//
//  MKTextField.swift
//


import Foundation
import UIKit

open class MKTextField: UIView {
    /// tableview 등에서 view 높이가 변경되어야 하는 경우 사용되는 값잆니다
    private weak var tableView: UITableView?
    public private(set) var viewHeight: CGFloat = 0.0
    
    public weak var delegate: MKTextFieldDelegate?
    
    /// Override Textfield
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        return self.textField.resignFirstResponder()
    }
    
    /// Override Textfield
    open var text: String {
        get {
            return self.textField.text ?? ""
        }
        set {
            self.textField.text = newValue
            self.updateCounter()
            if self.options.limitCount < newValue.count {
                self.validTextFieldLimitted()
            }
            
        }
    }
    var trimmed: Bool = false
    
    /// Override Textfield
    public var placeHolderText: String? {
        get {
            return self.textField.attributedPlaceholder?.string ?? ""
        }
        set {
            if let newValue = newValue {
                self.textField.setPlaceholderText(text: newValue)
            }
            else {
                self.placeHolderAttributeString = nil
                self.textField.placeHolderText = ""
            }
        }
    }
    
    /// Override Textfield
    public var placeHolderAttributeString: NSAttributedString? {
        get {
            return self.textField.attributedPlaceholder
        }
        set {
            self.textField.attributedPlaceholder = newValue
        }
    }
    
    
    /// saved error message in `SetError` method
    public private(set) var errMessage: String = ""
    
    /// Override Textfield
    public var isEnabled: Bool {
        get {
            return self.textField.isUserInteractionEnabled
        }
        set {
            if newValue {
                self.updateStatus()
            }
            else {
                self.textFieldStatus = .disabled
            }
            
            self.textField.isUserInteractionEnabled = newValue
        }
    }

    /// Override Textfield
    public var returnKeyType: UIReturnKeyType {
        get {
            return self.textField.returnKeyType
        }
        set {
            self.textField.returnKeyType = newValue
        }
    }
    
    /// Override Textfield
    public var attributedText: NSAttributedString? {
        get {
            return self.textField.attributedText
        }
        set {
            self.textField.attributedText = newValue
        }
    }
    
    /// Override Textfield
    public var clearsOnBeginEditing: Bool {
        get {
            return self.textField.clearsOnBeginEditing
        }
        set {
            self.textField.clearsOnBeginEditing = newValue
        }
    }
    
    /// Override Textfield
    public var isEditing: Bool {
        get {
            return self.textField.isEditing
        }
    }
    
    lazy var rootStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 4
        v.alignment = .fill
        v.distribution = .fill
        v.addArrangedSubview(topAreaContentView)
        v.addArrangedSubview(subStackView)
        
        return v
    }()
    
    lazy var topAreaContentView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.addSubview(titleLabel)
        v.addSubview(counterLabel)
        return v
    }()
    
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = self.options.title
        v.isHidden = options.title?.isEmpty ?? true
        v.font = UIFont.systemFont(ofSize: 14)
        v.textColor = UIColor.setColorSet(.text_secondary)
        return v
    }()
    
    lazy var counterLabel: UILabel = {
        let v = UILabel()
        v.isHidden = !self.options.counter
        v.textColor = UIColor.setColorSet(.text_secondary)
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    lazy var subStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 8
        v.alignment = .fill
        v.distribution = .fill
        v.addArrangedSubview(textFieldBgView)
        v.addArrangedSubview(bottomAreaContentView)
        return v
    }()
    
    lazy var leadingImageView: UIImageView = {
        let v = UIImageView()
        v.image = nil
        return v
    }()
    
    lazy var tfStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = 12
        v.alignment = .center
        v.distribution = .fill
        v.addArrangedSubview(leadingImageView)
        v.addArrangedSubview(textField)
        return v
    }()
    
    lazy open var textFieldBgView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.addSubview(tfStackView)
        return v
    }()
    
    lazy public var textField: MKTextFieldCore = {
        let v = MKTextFieldCore(frame: self.bounds)
        v.placeHolderText = self.options.placeHolder
        return v
    }()
    
    lazy var bottomAreaContentView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.addSubview(helperTextLabel)
        v.addSubview(errorDescriptionLabel)
        return v
    }()
    
    lazy var helperTextLabel: UILabel = {
        let v = UILabel()
        v.isHidden = !self.options.counter
        v.textColor = UIColor.setColorSet(.text_disabled)
        v.font = UIFont.systemFont(ofSize: 14)
        v.font = UIFont.systemFont(ofSize: 14)
        if let helperText = self.options.helperText {
            v.text = helperText
        }
        return v
    }()
    
    lazy var errorDescriptionLabel: UILabel = {
        let v = UILabel()
        v.isHidden = !self.options.counter
        v.textColor = UIColor.setColorSet(.text_disabled)
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    private(set) var options: MKTextFieldOptions = MKTextFieldOptions()
    
    private var _textFieldStatus: TextFieldStatus = .normal
    private(set) var textFieldStatus: TextFieldStatus {
        get {
            return self._textFieldStatus
        }
        set {
            self._textFieldStatus = newValue
            self.setOutline(status: newValue)
            self.setTextFieldEnable(status: newValue)
        }
    }
    
    /// When Automatically useable Count Limitted Error Message
    /// - Note : Can Use either delegate?.textFieldLimitted
    private(set) var isTextCountLimitted: Bool = false {
        didSet {
            /// 최대 글자수 도달 시 자동으로 출력되는 메시지가 설정되어있는 경우
            if let msg = self.options.autoLimitCountErrorMessage, msg.isEmpty {
                self.setError(isOn: oldValue, errorMsg: msg)
            }
            
        }
    }
    
    public init() {
        super.init(frame: .zero)
        self.commonInit()
    }
    
    public override func awakeFromNib() {
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.setLayout()
        self.setObservers()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func draw(_ rect: CGRect) {
        self.setHeight()
        self.setOutline(status: self.textFieldStatus)
    }
    
}

public extension MKTextField {
    
    
    /// UITest 및 예제용 함수입니다
    @available(*, deprecated, message: "This Method is Not Logical - Only use for Test")
    func setTextfieldStatus(status: TextFieldStatus, forceFocus: Bool) {
        self.text = ""
        self.textFieldStatus = status
        switch status {
                
            case .normal:
                if forceFocus {
                    self.textFieldStatus = .focused
                    self.setOutline(status: .focused)
                }
                
            case .activate:
                self.text = "abc1234abc1234abc1234abc1234abc1234abc1234"
                if forceFocus {
                    self.setOutline(status: .focused)
                }
            case .focused:
                self.text = "abc1234"
                self.setOutline(status: .focused)
                self.textField.clearButtonMode = .always
            case .error:
                self.text = "abc1234abc1234abc1234abc1234abc1234abc1234"
                self.setError(isOn: true, errorMsg: "에러 메시지")
            case .disabled:
                self.text = "abc1234abc1234abc1234abc1234abc1234abc1234"
                self.setOutline(status: .disabled)
        }
    }
    
    /// Error Text 를 수동으로 노출시키거나 제거할 때 사용됩니다
    /// View (Cell) 높이는 자동으로 업데이트 됩니다
    /// - Parameters:
    ///   - isOn: 출력 여부 (Boolean)
    ///   - errorMsg: 출력할 메시지 (String)
    func setError(isOn: Bool, errorMsg: String = "") {
        self.errorDescriptionLabel.isHidden = !isOn
        self.helperTextLabel.isHidden = isOn
        if isOn {
            self.errMessage = errorMsg
            self.textFieldStatus = .error
            self.errorDescriptionLabel.text = errorMsg
        }
        else {
            self.updateStatus()
            
        }
        
        self.setHeight()
    }
    
    /// SFTextField를 세팅하는 SFTextFieldOptions 입니다
    /// - Parameters:
    ///   - option: `SFTextFieldOptions` 를 참고하세요
    ///   - tableView: TableView Cell 안에 넣는 경우 적용합니다
    ///   - important:TableView를 넘기지 않는 경우 에러 메시지로 인한 텍스트 높이 변경이 수동으로 이뤄져야 합니다
    
    func configure(option: MKTextFieldOptions, tableView: UITableView? = nil) {
        self.tableView = tableView
        self.options = option
        if let msg = options.autoLimitCountErrorMessage {
            if msg.isEmpty {
                fatalError("autoLimitCountErrorMessage Setted but empty string")
            }
            if options.limitCount == 0 {
                fatalError("autoLimitCountErrorMessage Setted but limitCount not Setted")
            }
        }
        self.setUI()
        self.setHeight()
        let textFieldStatus = self._textFieldStatus
        self.textFieldStatus = textFieldStatus
    }

    
}


// MARK: - UI
extension MKTextField {
    private func setHeight() {
        var expectHeight = Appearance.textFieldHeight
        
        // top
        if options.title != nil || options.counter == true {
            expectHeight += Appearance.topAreaHeight
            self.topAreaContentView.isHidden = false
        }
        else {
            self.topAreaContentView.isHidden = true
        }
        
        // bottom
        if (self.textFieldStatus == .error && errMessage.isEmpty) || !(options.helperText?.isEmpty ?? true) {
            expectHeight += Appearance.bottomAreaHeight
            self.bottomAreaContentView.isHidden = false
        }
        else {
            self.bottomAreaContentView.isHidden = true
        }
        
//        self.constraints.forEach { (constraint) in
//            if constraint.firstAttribute == .height {
//                constraint.constant = expectHeight
//            }
//            else {
//                NSLayoutConstraint.activate([
//                    self.heightAnchor.constraint(equalToConstant: expectHeight)
//                ])
//
//            }
//        }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: expectHeight).isActive = true
        
        if self.viewHeight != expectHeight {
            self.updateTableViewHeight()
        }
        self.viewHeight = expectHeight
    }
    
    
    private func updateTableViewHeight() {
        UIView.setAnimationsEnabled(false)
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    private func setOutline(status: TextFieldStatus) {
        if self.options.inputType == .outLine {
            self.textFieldBgView.toCornerRound(corners: [.allCorners], radius: 8.0, borderColor: UIColor.setColorSet(status.outLine), backgroundColor: UIColor.setColorSet(.grey50), borderWidth: 1.0)
        }
        else {
            self.textFieldBgView.toCornerRound(corners: [.allCorners], radius: 8.0, borderColor: UIColor.setColorSet(status.fill.outline), backgroundColor: UIColor.setColorSet(status.fill.background), borderWidth: 1.0)
        }
        
    }
    fileprivate func setLayout() {
        self.addSubview(self.rootStackView)
        
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        let rootStackConstraints = [
            rootStackView.topAnchor.constraint(equalTo: rootStackView.superview!.topAnchor, constant: 0),
            rootStackView.leftAnchor.constraint(equalTo: rootStackView.superview!.leftAnchor, constant: 0),
            rootStackView.rightAnchor.constraint(equalTo: rootStackView.superview!.rightAnchor, constant: 0),
            rootStackView.bottomAnchor.constraint(equalTo: rootStackView.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(rootStackConstraints)
        
        self.topAreaContentView.translatesAutoresizingMaskIntoConstraints = false
        let topAreaContentViewConstraints = [
            topAreaContentView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(topAreaContentViewConstraints)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: titleLabel.superview!.leftAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: titleLabel.superview!.rightAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        self.counterLabel.translatesAutoresizingMaskIntoConstraints = false
        let counterLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: counterLabel.superview!.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: counterLabel.superview!.leftAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: counterLabel.superview!.rightAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: counterLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(counterLabelConstraints)
        
        self.tfStackView.translatesAutoresizingMaskIntoConstraints = false
        let tfStackViewConstraints = [
            tfStackView.topAnchor.constraint(equalTo: tfStackView.superview!.topAnchor, constant: 0),
            tfStackView.leftAnchor.constraint(equalTo: tfStackView.superview!.leftAnchor, constant: 16),
            tfStackView.rightAnchor.constraint(equalTo: tfStackView.superview!.rightAnchor, constant: -16),
            tfStackView.bottomAnchor.constraint(equalTo: tfStackView.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(tfStackViewConstraints)

        self.textField.translatesAutoresizingMaskIntoConstraints = false
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: textField.superview!.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: textField.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)

        self.leadingImageView.translatesAutoresizingMaskIntoConstraints = false
        let leadingImageViewConstraints = [
            leadingImageView.widthAnchor.constraint(equalToConstant: 20),
            leadingImageView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(leadingImageViewConstraints)
    
        self.bottomAreaContentView.translatesAutoresizingMaskIntoConstraints = false
        let bottomAreaContentViewConstraints = [
            bottomAreaContentView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(bottomAreaContentViewConstraints)
        
        self.helperTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let helperTextLabelConstraints = [
            helperTextLabel.topAnchor.constraint(equalTo: helperTextLabel.superview!.topAnchor, constant: 0),
            helperTextLabel.leftAnchor.constraint(equalTo: helperTextLabel.superview!.leftAnchor, constant: 0),
            helperTextLabel.bottomAnchor.constraint(equalTo: helperTextLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(helperTextLabelConstraints)
        
        self.errorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let errorDescriptionLabelConstraints = [
            errorDescriptionLabel.topAnchor.constraint(equalTo: errorDescriptionLabel.superview!.topAnchor, constant: 0),
            errorDescriptionLabel.leftAnchor.constraint(equalTo: errorDescriptionLabel.superview!.leftAnchor, constant: 0),
            errorDescriptionLabel.bottomAnchor.constraint(equalTo: errorDescriptionLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(errorDescriptionLabelConstraints)
    }
    
    
    fileprivate func setUI() {
        self.setTextField()
        self.setTopAreaUI()
        self.setBottomAreaUI()
        self.updateCounter()
    }
    
    private func setTextField() {
        self.textField.placeHolderText = self.options.placeHolder
        self.textField.delegate = self
        
        if let leadingIcon = self.options.leadingIcon {
            self.leadingImageView.image = leadingIcon
            self.leadingImageView.isHidden = false
        }
        else {
            self.leadingImageView.isHidden = true
        }
    }
    
    private func setTopAreaUI() {
        self.topAreaContentView.backgroundColor = .clear
        self.titleLabel.text = self.options.title
        self.titleLabel.isHidden = options.title?.isEmpty ?? true
        self.counterLabel.isHidden = !self.options.counter
    }
    
    private func setBottomAreaUI() {
        self.bottomAreaContentView.backgroundColor = .clear
        
        if let helperText = self.options.helperText {
            self.helperTextLabel.text = helperText
        }
        self.helperTextLabel.isHidden = self.options.helperText?.isEmpty ?? true
        self.errorDescriptionLabel.isHidden = true
    }
    
}


// MARK: - DATA
extension MKTextField {
    
    private func setTextFieldEnable(status: TextFieldStatus) {
        self.textField.isUserInteractionEnabled = status != .disabled
        
    }
}
// MARK: - TextField
extension MKTextField {
    fileprivate func setObservers() {
        let textField = self.textField
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldTextDidEndEditing),
            name: UITextField.textDidEndEditingNotification,
            object: textField)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldTextDidBeginEditing),
            name: UITextField.textDidBeginEditingNotification,
            object: textField
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldTextChanged),
            name: UITextField.textDidChangeNotification,
            object: textField
        )
        
        
    }
    
    // MARK: - TextField Editing Observer
    @objc private func textFieldTextDidBeginEditing(notification : NSNotification) {
        self.textFieldStatus = .focused
        self.delegate?.textFieldTextDidBeginEditing?(self)
    }
    
    @objc private func textFieldTextDidEndEditing(notification : NSNotification) {
        guard let text = self.textField.text else { return }
        if text.isEmpty {
            self.textFieldStatus = .normal
        }
        else {
            if self.textFieldStatus != .error {
                self.textFieldStatus = .activate
            }
            
        }
        
        self.delegate?.textFieldTextDidEndEditing?(self)
    }
    
    private func validTextFieldLimitted() {
        let inputText = self.text
        let limitCount = options.limitCount
        
        if limitCount != 0 {
            let isLimmit = inputText.count > limitCount
            
            self.isTextCountLimitted = isLimmit
            self.delegate?.textFieldLimitted?(self, limitted: isLimmit)
            
            if inputText.count > limitCount {
                let trimmed = String(inputText.prefix(limitCount))
                self.text = trimmed
            }
            
        }
    }
    
    
    @objc private func textFieldTextChanged(notifcation: NSNotification) {
        self.validTextFieldLimitted()
        self.updateCounter()
        self.delegate?.textFieldTextDidChange?(self, text: self.text)
    }
    
    private func updateCounter() {
        
        self.counterLabel.text = "\(self.text.count)/\(self.options.limitCount)"
    }
    
    private func updateStatus() {
        if self.textField.isFirstResponder {
            self.textFieldStatus = .focused
        }
        else {
            if self.textField.hasText {
                self.textFieldStatus = .normal
            }
            else {
                self.textFieldStatus = .activate
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension MKTextField: UITextFieldDelegate {
    
    /// Textfield를 직접적으로 Overriding 할 수는 있으나 delegate 로 제공되는 `textFieldShouldReturn` 를 쓰기 권장합니다
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let v = self.delegate?.textFieldShouldReturn?(self)
        return v ?? true
        
    }
    
    /// Textfield를 직접적으로 Overriding 할 수는 있으나 delegate 로 제공되는 `textFieldShouldReturn` 를 쓰기 권장합니다
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let v = self.delegate?.textFieldShouldReturn?(self)
        return v ?? true
    }
    
}

extension MKTextField {
    struct Appearance {
        static let textFieldHeight: CGFloat = 56
        static let topAreaHeight: CGFloat = 24
        static let bottomAreaHeight: CGFloat = 28
    }
}

