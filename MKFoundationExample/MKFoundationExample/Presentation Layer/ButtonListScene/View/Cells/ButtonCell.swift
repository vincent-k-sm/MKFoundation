//
//  ButtonCell.swift
//


import Foundation
import UIKit
import SnapKit

class ButtonCell: UITableViewCell {
    
    lazy var mkButton: UIButton = {
        let v = UIButton()
        v.setTitle("Button", for: .normal)
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
extension ButtonCell {
    private func setUI() {
        self.contentView.addSubview(self.mkButton)
        mkButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20).priority(750)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
