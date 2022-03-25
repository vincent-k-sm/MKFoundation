//
//  MKTextView.swift
//


import Foundation
import UIKit

open class MKTextView: UIView {
    /// tableview 등에서 view 높이가 변경되어야 하는 경우 사용되는 값잆니다
    private weak var tableView: UITableView?
    public private(set) var viewHeight: CGFloat = 0.0
    
    /// Default Delegate
    public weak var delegate: MKTextViewDelegate?
    
    /// Override TextView
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        return self.textView.becomeFirstResponder()
    }
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        return self.textView.resignFirstResponder()
    }
    
    lazy var toolbar: UIToolbar = {
       let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        return toolbar
    }()
    
    /// Override TextView
    open var text: String {
        get {
            return self.textView.text ?? ""
        }
        set {
            self.textView.text = newValue
            if self.options.limitCount < newValue.count {
                self.validtextViewLimitted()
            }
            else {
                self.delegate?.textViewTextDidChange?(self, text: newValue)
            }
            
            self.updateCounter()
            self.setHeight()
    
        }
    }
    /// Override TextView
    public var selectedRange: NSRange {
        get {
            return self.textView.selectedRange
        }
        set {
            self.textView.selectedRange = newValue
        }
    }
    
    /// Override TextView
    public var placeHolderText: String? {
        get {
            return self.textView.placeHolderText
        }
        set {
            if let newValue = newValue {
                self.textView.setPlaceholderText(text: newValue)
            }
            else {
                self.textView.placeHolderText = ""
            }
        }
    }
    
    /// Override textView
    public var placeHolderAttributeString: NSAttributedString? {
        get {
            return self.textView.placeHolderAttributeString
        }
    }
    
    /// saved error message in `SetError` method
    public private(set) var errMessage: String = ""
    
    /// Override textView
    public var isEnabled: Bool {
        get {
            return self.textView.isUserInteractionEnabled
        }
        set {
            if newValue {
                self.updateStatus()
            }
            else {
                self.textViewStatus = .disabled
            }
            
            self.textView.isUserInteractionEnabled = newValue
        }
    }

    /// Override textView
    public var returnKeyType: UIReturnKeyType {
        get {
            return self.textView.returnKeyType
        }
        set {
            self.textView.returnKeyType = newValue
        }
    }
    
    /// Override textView
    public var attributedText: NSAttributedString? {
        get {
            return self.textView.attributedText
        }
        set {
            self.textView.attributedText = newValue
            
        }
    }
    
    /// Override textView
    public var isEditing: Bool {
        get {
            return self.textView.isFirstResponder
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
        v.addArrangedSubview(textViewBgView)
        v.addArrangedSubview(bottomAreaContentView)
        return v
    }()
    
    lazy open var textViewBgView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.addSubview(textView)
        return v
    }()
    
    lazy public var textView: MKTextViewCore = {
        let v = MKTextViewCore(frame: self.bounds)
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
        if let helperText = self.options.helperText {
            v.text = helperText
        }
        return v
    }()
    
    lazy var errorDescriptionLabel: UILabel = {
        let v = UILabel()
        v.isHidden = !self.options.counter
        v.textColor = UIColor.setColorSet(.red)
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    
    private(set) var options: MKTextViewOptions = MKTextViewOptions()
    public private(set) var isOnError: Bool = false
    
    private var _textViewStatus: TextViewStatus = .normal
    private(set) var textViewStatus: TextViewStatus {
        get {
            return self._textViewStatus
        }
        set {
            self._textViewStatus = newValue
            self.setOutline(status: newValue)
            self.settextViewEnable(status: newValue)
        }
    }
    
    /// When Automatically useable Count Limitted Error Message
    /// - Note : Can Use either delegate?.textViewLimitted
    private(set) var isTextCountLimitted: Bool = false {
        didSet {
            /// 최대 글자수 도달 시 자동으로 출력되는 메시지가 설정되어있는 경우
            if let msg = self.options.autoLimitCountErrorMessage, !msg.isEmpty {
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
        self.setOutline(status: self.textViewStatus)
    }
    
}

public extension MKTextView {
    func setTextViewStatus(status: TextViewStatus) {
        self.textViewStatus = status
        if (self.isOnError && status != .error) {
            self.setError(isOn: false)
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
            self.textViewStatus = .error
            self.errorDescriptionLabel.text = errorMsg
        }
        else {
            self.updateStatus()
            
        }
        self.isOnError = isOn
        self.setHeight()
    }
    
    /// MKTextView를 세팅하는 MKTextViewOptions 입니다
    /// - Parameters:
    ///   - option: `MKTextViewOptions` 를 참고하세요
    ///   - tableView: TableView Cell 안에 넣는 경우 적용합니다
    ///   - important:TableView를 넘기지 않는 경우 에러 메시지로 인한 텍스트 높이 변경이 수동으로 이뤄져야 합니다
    
    func configure(option: MKTextViewOptions, tableView: UITableView? = nil, customToolbar: Bool = false) {
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
        if !customToolbar {
            self.setToolBar()
        }
        
        let textViewStatus = self._textViewStatus
        self.textViewStatus = textViewStatus
    }
    
}

// MARK: - UI
extension MKTextView {
    private func setHeight() {
        
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        var expectHeight: CGFloat = 0.0
        
        if self.options.textViewHeight.isZero {
            expectHeight = (newSize.height > Appearance.textViewHeight ? newSize.height + Appearance.topBottomMargin : Appearance.textViewHeight)
        }
        else {
            expectHeight = self.options.textViewHeight + Appearance.topBottomMargin
        }

        // top
        if options.title != nil || options.counter == true {
            expectHeight += Appearance.topAreaHeight
            self.topAreaContentView.isHidden = false
        }
        else {
            self.topAreaContentView.isHidden = true
        }
        
        // bottom
        if (self.textViewStatus == .error && !errMessage.isEmpty) || !(options.helperText?.isEmpty ?? true) {
            expectHeight += Appearance.bottomAreaHeight
            self.bottomAreaContentView.isHidden = false
        }
        else {
            self.bottomAreaContentView.isHidden = true
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let heightConst = self.constraints.filter({ $0.firstAttribute == .height }).first {
            heightConst.constant = expectHeight
        }
        else {
            self.heightAnchor.constraint(equalToConstant: expectHeight).isActive = true
        }
        
        if self.viewHeight != expectHeight {
            self.updateTableViewHeight(size: size, newSize: newSize)
        }
        self.viewHeight = expectHeight
    }
    
    private func updateTableViewHeight(size: CGSize, newSize: CGSize) {
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            self.tableView?.beginUpdates()
            self.tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            
        }
    }
    
    private func setOutline(status: TextViewStatus) {
        if self.options.inputType == .outLine {
            self.textViewBgView.toCornerRound(corners: [.allCorners], radius: 8.0, borderColor: UIColor.setColorSet(status.outLine), backgroundColor: UIColor.setColorSet(.grey50), borderWidth: 1.0)
        }
        else {
            self.textViewBgView.toCornerRound(corners: [.allCorners], radius: 8.0, borderColor: UIColor.setColorSet(status.fill.outline), backgroundColor: UIColor.setColorSet(status.fill.background), borderWidth: 1.0)
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
            counterLabel.topAnchor.constraint(equalTo: counterLabel.superview!.topAnchor, constant: 0),
            counterLabel.rightAnchor.constraint(equalTo: counterLabel.superview!.rightAnchor, constant: 0),
            counterLabel.bottomAnchor.constraint(equalTo: counterLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(counterLabelConstraints)

        self.textView.translatesAutoresizingMaskIntoConstraints = false
        let textViewConstraints = [
            textView.topAnchor.constraint(equalTo: textView.superview!.topAnchor, constant: 6),
            textView.leftAnchor.constraint(equalTo: textView.superview!.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: textView.superview!.rightAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: textView.superview!.bottomAnchor, constant: 6)
        ]
        NSLayoutConstraint.activate(textViewConstraints)
    
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
        self.setTextView()
        self.setTopAreaUI()
        self.setBottomAreaUI()
        self.updateCounter()
    }
    
    private func setTextView() {
        self.textView.placeHolderText = self.options.placeHolder
    }
    
    private func setTopAreaUI() {

        self.titleLabel.text = self.options.title
        self.titleLabel.isHidden = options.title?.isEmpty ?? true
        self.counterLabel.isHidden = !self.options.counter
    }
    
    private func setBottomAreaUI() {
        if let helperText = self.options.helperText {
            self.helperTextLabel.text = helperText
        }
        self.helperTextLabel.isHidden = self.options.helperText?.isEmpty ?? true
        self.errorDescriptionLabel.isHidden = true
    }
    
    private func setToolBar() {
        
        var items: [UIBarButtonItem] = []
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        items.append(flexSpace)
        if self.options.doneAccessory {
            let done: UIBarButtonItem = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector(self.doneButtonAction))
            items.append(done)
        }
        
        if self.options.clearAccessory {
            let clear: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.clearButtonAction))
            clear.tintColor = .red
            items.insert(clear, at: 0)
        }
        
        if !items.isEmpty {
            self.toolbar.items = items
            self.toolbar.sizeToFit()
            self.textView.inputAccessoryView = self.toolbar
        }
        else {
            self.textView.inputAccessoryView = nil
        }
    }
    
    @objc func doneButtonAction() {
        self.textView.resignFirstResponder()
    }
    
    @objc public func clearButtonAction() {
        self.text = ""
        self.attributedText = nil
        self.setHeight()
        self.delegate?.textViewTextDidChange?(self, text: "")
        self.isTextCountLimitted = false
    }

}

// MARK: - DATA
extension MKTextView {
    
    private func settextViewEnable(status: TextViewStatus) {
        self.textView.isUserInteractionEnabled = status != .disabled
        
    }
}
// MARK: - textView
extension MKTextView {
    fileprivate func setObservers() {
        let textView = self.textView
        textView.delegate = self

//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(textViewTextDidEndEditing),
//            name: UITextView.textDidEndEditingNotification,
//            object: textView)
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(textViewTextDidBeginEditing),
//            name: UITextView.textDidBeginEditingNotification,
//            object: textView
//        )
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(textViewTextChanged),
//            name: UITextView.textDidChangeNotification,
//            object: textView
//        )
    
    }
    
    private func validtextViewLimitted() {
        let inputText = self.text
        let limitCount = options.limitCount
        
        if limitCount != 0 {
            self.isTextCountLimitted = inputText.count > limitCount
            self.delegate?.textViewLimitted?(self, limitted: self.isTextCountLimitted)
            if inputText.count > limitCount {
                let trimmed = String(inputText.prefix(limitCount))
                
                if !self.textView.attributedText.string.isEmpty {
                    let attrText = self.textView.attributedText.mutableCopy() as! NSMutableAttributedString
                    attrText.replaceCharacters(in: NSRange(location: limitCount, length: attrText.length - limitCount), with: "")
                    self.textView.attributedText = attrText
                }
                else {
                    self.text = trimmed
                }
                
                self.endEditing(true)
                self.delegate?.textViewTextDidChange?(self, text: self.text)
                self.setHeight()
            }
            
        }
    }
    
    private func updateCounter() {
        
        self.counterLabel.text = "\(self.text.count)/\(self.options.limitCount)"
    }
    
    private func updateStatus() {
        if self.textView.isFirstResponder {
            self.textViewStatus = .activate
        }
        else {
            if self.textView.hasText {
                self.textViewStatus = .normal
            }
            else {
                self.textViewStatus = .activate
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension MKTextView: UITextViewDelegate {
//    @objc private func textViewTextDidBeginEditing(notification : NSNotification) {
//        self.textViewStatus = .focused
//        self.delegate?.textViewTextDidBeginEditing?(self)
//    }
//
//    @objc private func textViewTextDidEndEditing(notification : NSNotification) {
//        guard let text = self.textView.text else { return }
//        if text.isEmpty {
//            self.textViewStatus = .normal
//        }
//        else {
//            if self.textViewStatus != .error {
//                self.textViewStatus = .activate
//            }
//
//        }
//
//        self.delegate?.textViewTextDidEndEditing?(self)
//    }
//
//    @objc private func textViewTextChanged(notifcation: NSNotification) {
//        self.validtextViewLimitted()
//        self.updateCounter()
//        self.delegate?.textViewTextDidChange?(self, text: self.text)
//        self.setHeight()
//    }
    
    open func textViewDidChange(_ textView: UITextView) {
        self.validtextViewLimitted()
        self.updateCounter()
        self.delegate?.textViewTextDidChange?(self, text: self.text)
        self.setHeight()

    }
    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        self.textViewStatus = .activate
        self.delegate?.textViewTextDidBeginEditing?(self)
    }

    open func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        if text.isEmpty {
            self.textViewStatus = .normal
        }
        else {
            if self.textViewStatus != .error {
                self.textViewStatus = .activate
            }

        }

        self.delegate?.textViewTextDidEndEditing?(self)
    }

    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

extension MKTextView {
    struct Appearance {
        static let textViewHeight: CGFloat = 48
        static let topAreaHeight: CGFloat = 24
        static let topBottomMargin: CGFloat = 15
        static let bottomAreaHeight: CGFloat = 28
    }
}
