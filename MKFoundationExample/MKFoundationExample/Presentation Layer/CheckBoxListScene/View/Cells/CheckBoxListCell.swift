//
//  CheckBoxListCell.swift
//


import Foundation
import UIKit
import MKFoundation

class CheckBoxListCell: UITableViewCell {
    
    lazy var mkCheckBox: MKCheckBox = {
        let v = MKCheckBox()

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
extension CheckBoxListCell {
    private func setUI() {
        self.contentView.addSubview(self.mkCheckBox)
        mkCheckBox.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
