//
//  ExampleListCell.swift
//


import Foundation
import UIKit
import SnapKit
import MKFoundation

class ExampleListCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .left
        v.numberOfLines = 0
        v.textColor = UIColor.setColorSet(.text_primary)

        v.font = UIFont.boldSystemFont(ofSize: 17)
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil 
    }
    
    deinit {
        print("\(self) - deinit")
    }
}

extension ExampleListCell {
    private func setUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
