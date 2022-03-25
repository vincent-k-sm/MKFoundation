//
//  TextFieldListCell.swift
//


import Foundation
import UIKit
import SnapKit
import MKFoundation

class TextFieldListCell: UITableViewCell {
    
    lazy var mkTextField: MKTextField = {
        let v = MKTextField()
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self) -- deinit")
    }
    
}
extension TextFieldListCell {
    private func setUI() {
        self.contentView.addSubview(self.mkTextField)
        mkTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20).priority(750)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
