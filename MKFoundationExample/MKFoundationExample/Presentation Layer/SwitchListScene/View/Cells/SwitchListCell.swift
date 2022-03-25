//
//  SwitchListCell.swift
//


import Foundation
import UIKit
import SnapKit
import MKFoundation

class SwitchListCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 17)
        v.textColor = UIColor.setColorSet(.text_primary)
        return v
    }()
    
    lazy var mkSwitch: MKSwitch = {
        let v = MKSwitch()
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

extension SwitchListCell {
    private func setUI() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(self.mkSwitch)
        self.mkSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(20).priority(750)
        }
    }
}
