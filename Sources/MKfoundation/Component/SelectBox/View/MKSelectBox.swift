//
//  MKSelectBox.swift
//


import Foundation
import UIKit

open class MKSelectBox: UIView {
    /// tableview 등에서 view 높이가 변경되어야 하는 경우 사용되는 값잆니다
    private weak var tableView: UITableView?
    public private(set) var viewHeight: CGFloat = 0.0
    
    public weak var delegate: MKSelectBoxDelegate?
    
    public var text: String {
        get {
            return self.textField.text ?? ""
        }
        set {
            self.textField.text = newValue
        }
    }
    
    /// saved error message in `SetError` method
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
            return self.actionButton.isEnabled
        }
        set {
            if !newValue {
                self.selectBoxStatus = .disabled
            }
            self.actionButton.isEnabled = newValue
        }
    }
    
    lazy var actionButton: UIButton = {
        let v = UIButton(type: .custom)
        v.setBackgroundColor(.clear, for: .normal)
        return v
    }()
    
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
    
    lazy var trailingImageView: UIImageView = {
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
        v.addArrangedSubview(textField)
        v.addArrangedSubview(trailingImageView)
        
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
        v.textColor = UIColor.setColorSet(.red)
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    public private(set) var options: MKSelectBoxOptions = MKSelectBoxOptions()
    private var currentStatus: SelectBoxStatus? = nil
    public private(set) var isOnError: Bool = false
    
    private var _selectBoxStatus: SelectBoxStatus = .normal
    public private(set) var selectBoxStatus: SelectBoxStatus {
        get {
            return self._selectBoxStatus
        }
        set {
            self._selectBoxStatus = newValue
            self.setOutline(status: newValue)
            self.setSelectboxEnable(status: newValue)
            self.updateIcon(status: newValue)
            if newValue != .error {
                self.currentStatus = newValue
            }
            self.delegate?.didChangeStatus(self, status: newValue)
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
        self.setOutline(status: self.selectBoxStatus)
    }
    
}


public extension MKSelectBox {
    func clear() {
        self.text = ""
    }
    
    func setSelectboxStatus(status: SelectBoxStatus) {
        self.selectBoxStatus = status
        if (self.isOnError && status != .error) {
            self.setError(isOn: false)
        }
        
    }
    
    
    /// UITest 및 예제용 함수입니다
    @available(*, deprecated, message: "This Method is Not Logical - Only use for Test")
    func setSelectBoxStatus(status: SelectBoxStatus, forceFocus: Bool) {
        self.selectBoxStatus = status
        switch status {
                
            case .normal:
                if forceFocus {
                    self.selectBoxStatus = .focused
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
            self.selectBoxStatus = .error
            self.errorDescriptionLabel.text = errorMsg
        }
        else {
            self.revertStatus()
            
        }
        self.isOnError = isOn
        self.setHeight()
    }
    
    /// MKSelectBox를 세팅하는 MKSelectBoxOptions 입니다
    /// - Parameters:
    ///   - option: `MKSelectBoxOptions` 를 참고하세요
    ///   - tableView: TableView Cell 안에 넣는 경우 적용합니다
    ///   - important:TableView를 넘기지 않는 경우 에러 메시지로 인한 텍스트 높이 변경이 수동으로 이뤄져야 합니다
    
    func configure(option: MKSelectBoxOptions, tableView: UITableView? = nil) {
        self.tableView = tableView
        self.options = option
        self.placeHolderText = option.placeHolder
        self.setUI()
        self.setHeight()
        let selectBoxStatus = self._selectBoxStatus
        self.selectBoxStatus = selectBoxStatus
    }

    
}


// MARK: - UI
extension MKSelectBox {
    private func setHeight() {
        var expectHeight = Appearance.textFieldHeight
        
        // top
        if options.title != nil {
            expectHeight += Appearance.topAreaHeight
            self.topAreaContentView.isHidden = false
        }
        else {
            self.topAreaContentView.isHidden = true
        }
        
        // bottom
        if (self.selectBoxStatus == .error && !errMessage.isEmpty) || !(options.helperText?.isEmpty ?? true) {
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
    
    private func setOutline(status: SelectBoxStatus) {
        
        if self.options.inputType == .outLine {
            self.textFieldBgView.toCornerRound(corners: [.allCorners], radius: 8.0, borderColor: UIColor.setColorSet(status.outLine), backgroundColor: .white, borderWidth: 1.0)
        }
        else {
            self.textFieldBgView.toCornerRound(corners: [.allCorners], radius: 8.0, borderColor: UIColor.setColorSet(status.fill.outline), backgroundColor: UIColor.setColorSet(status.fill.background), borderWidth: 1.0)
        }
        
    }
    
    
    private func updateIcon(status: SelectBoxStatus) {
        if status == .disabled {
            self.trailingImageView.image = Appearance.symbolImageDisable
        }
        else {
            self.trailingImageView.image = Appearance.symbolImage
        }
    }

    
    fileprivate func setUI() {
        
        self.setTopAreaUI()
        self.setSelecboxUI()
        self.setBottomAreaUI()
    }
    
    fileprivate func setLayout() {
        self.addSubview(self.rootStackView)
        self.rootStackView.translatesAutoresizingMaskIntoConstraints = false
        let rootStackConstraints = [
            rootStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            rootStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            rootStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(rootStackConstraints)
        
//        self.rootStackView.snp.makeConstraints { make in
//            make.top.left.right.bottom.equalToSuperview().offset(0)
//        }
        
        self.topAreaContentView.translatesAutoresizingMaskIntoConstraints = false
        let topAreaContentViewConstraints = [
            topAreaContentView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(topAreaContentViewConstraints)
        
//        self.topAreaContentView.snp.makeConstraints { make in
//            make.height.equalTo(20)
//        }
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: titleLabel.superview!.rightAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: titleLabel.superview!.leftAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        
//        self.titleLabel.snp.makeConstraints { make in
//            make.top.left.bottom.equalToSuperview().offset(0)
//        }

        self.tfStackView.translatesAutoresizingMaskIntoConstraints = false
        let tfStackViewConstraints = [
            tfStackView.topAnchor.constraint(equalTo: tfStackView.superview!.topAnchor, constant: 0),
            tfStackView.rightAnchor.constraint(equalTo: tfStackView.superview!.rightAnchor, constant: 0),
            tfStackView.leftAnchor.constraint(equalTo: tfStackView.superview!.leftAnchor, constant: 16),
            tfStackView.bottomAnchor.constraint(equalTo: tfStackView.superview!.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(tfStackViewConstraints)
        
//        self.tfStackView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(0)
//            make.bottom.equalToSuperview().inset(0)
//            make.left.equalToSuperview().offset(16)
//            make.right.equalToSuperview().inset(16)
//        }

        self.textField.translatesAutoresizingMaskIntoConstraints = false
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: textField.superview!.topAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: textField.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)
        
//        self.textField.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(0)
//            make.bottom.equalToSuperview().inset(0)
//        }

        self.trailingImageView.translatesAutoresizingMaskIntoConstraints = false
        let trailingImageViewConstraints = [
            trailingImageView.widthAnchor.constraint(equalToConstant: 20),
            trailingImageView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(trailingImageViewConstraints)
        
//        self.trailingImageView.snp.makeConstraints { make in
//            make.width.height.equalTo(20)
//        }
    
        self.bottomAreaContentView.translatesAutoresizingMaskIntoConstraints = false
        let bottomAreaContentViewConstraints = [
            bottomAreaContentView.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(bottomAreaContentViewConstraints)
        
//        self.bottomAreaContentView.snp.makeConstraints { make in
//            make.height.equalTo(20)
//        }
        
        self.helperTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let helperTextLabelConstraints = [
            helperTextLabel.topAnchor.constraint(equalTo: helperTextLabel.superview!.topAnchor, constant: 0),
            helperTextLabel.leftAnchor.constraint(equalTo: helperTextLabel.superview!.leftAnchor, constant: 0),
            helperTextLabel.bottomAnchor.constraint(equalTo: helperTextLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(helperTextLabelConstraints)
        
//        self.helperTextLabel.snp.makeConstraints { make in
//            make.top.left.bottom.equalToSuperview().offset(0)
//        }
        
        self.errorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let errorDescriptionLabelConstraints = [
            errorDescriptionLabel.topAnchor.constraint(equalTo: errorDescriptionLabel.superview!.topAnchor, constant: 0),
            errorDescriptionLabel.leftAnchor.constraint(equalTo: errorDescriptionLabel.superview!.leftAnchor, constant: 0),
            errorDescriptionLabel.bottomAnchor.constraint(equalTo: errorDescriptionLabel.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(errorDescriptionLabelConstraints)
        
//        self.errorDescriptionLabel.snp.makeConstraints { make in
//            make.top.left.bottom.equalToSuperview().offset(0)
//        }
        self.addSubview(self.actionButton)
        self.actionButton.translatesAutoresizingMaskIntoConstraints = false
        let actionButtonConstraints = [
            actionButton.topAnchor.constraint(equalTo: actionButton.superview!.topAnchor, constant: 0),
            actionButton.rightAnchor.constraint(equalTo: actionButton.superview!.rightAnchor, constant: 0),
            actionButton.leftAnchor.constraint(equalTo: actionButton.superview!.leftAnchor, constant: 0),
            actionButton.bottomAnchor.constraint(equalTo: actionButton.superview!.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(actionButtonConstraints)
        
//        self.addSubview(self.actionButton)
//        self.actionButton.snp.makeConstraints { make in
//            make.top.left.bottom.right.equalTo(textFieldBgView)
//        }
    }

    
    private func setSelecboxUI() {
        self.textField.placeHolderText = self.options.placeHolder
        self.actionButton.setTitle(nil, for: .normal)
    }
    
    private func setTopAreaUI() {
        self.topAreaContentView.backgroundColor = .clear
        self.titleLabel.text = self.options.title
        self.titleLabel.isHidden = options.title?.isEmpty ?? false
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel.textColor = UIColor.setColorSet(.text_secondary)

    }
    
    private func setBottomAreaUI() {
        self.bottomAreaContentView.backgroundColor = .clear
        self.errorDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        self.errorDescriptionLabel.textColor = UIColor.setColorSet(.red)
        
        self.helperTextLabel.font = UIFont.systemFont(ofSize: 14)
        self.helperTextLabel.textColor = UIColor.setColorSet(.text_disabled)
        
        if let helperText = self.options.helperText {
            self.helperTextLabel.text = helperText
        }
        self.helperTextLabel.isHidden = self.options.helperText?.isEmpty ?? false
        self.errorDescriptionLabel.isHidden = true
    }
    
}


// MARK: - DATA
extension MKSelectBox {
    
    private func setSelectboxEnable(status: SelectBoxStatus) {
        self.actionButton.isEnabled = status != .disabled
        self.textField.isUserInteractionEnabled = status != .disabled
    }
}
// MARK: - SelectBox
extension MKSelectBox {
    fileprivate func setObservers() {
        self.actionButton.addTarget(self, action: #selector(self.selectBoxTapped), for: .touchUpInside)
    }
    
    private func revertStatus() {
        if let currentStatus = self.currentStatus {
            self.selectBoxStatus = currentStatus
        }
    }
    
    @objc
    private func selectBoxTapped() {
        self.delegate?.didSelected(self)
    }

}

extension MKSelectBox {
    struct Appearance {
        static let textFieldHeight: CGFloat = 56
        static let topAreaHeight: CGFloat = 24
        static let bottomAreaHeight: CGFloat = 28
        static let symbolImage: UIImage? = UIImage(named: "ic_dropdown.png", in: Bundle.module, compatibleWith: nil) ?? nil
        static let symbolImageDisable: UIImage? = UIImage(named: "ic_dropdown_disable.png", in: Bundle.module, compatibleWith: nil) ?? nil
    }
}

