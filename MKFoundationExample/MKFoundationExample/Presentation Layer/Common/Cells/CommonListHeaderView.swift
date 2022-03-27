//
//  SelectBoxListHeaderView.swift
//


import Foundation
import UIKit
import SnapKit
import MKFoundation

class CommonListHeaderView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.boldSystemFont(ofSize: 18)
        v.textColor = UIColor.setColorSet(.text_primary)
        return v
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommonListHeaderView {
    private func setUI() {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.setColorSet(.background_elevated)
        self.backgroundView = bgView
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
