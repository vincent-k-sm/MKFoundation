//
//  SelectBoxListCell.swift
//


import Foundation
import UIKit
import SnapKit
import MKFoundation

class SelectBoxListCell: UITableViewCell {
    
    lazy var mkSelectBox: MKSelectBox = {
        let v = MKSelectBox()
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
extension SelectBoxListCell {
    private func setUI() {
        self.contentView.addSubview(self.mkSelectBox)
        mkSelectBox.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20).priority(750)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
