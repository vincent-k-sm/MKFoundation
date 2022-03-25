//
//  TextViewListDiffableDataSource.swift
//


import Foundation
import UIKit
import MKFoundation

enum TextViewListCellTypes: Hashable, Equatable {
    case item(option: MKTextViewOptions, status: TextViewStatus)
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case let (.item(lv1, lv2), .item(rv1, rv2)):
                return lv1 == rv1 && lv2 == rv2
        }
        
    }
}

class TextViewListDiffableDataSource: UITableViewDiffableDataSource<TextViewStatus, TextViewListCellTypes> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<TextViewStatus, TextViewListCellTypes>
    
    var currentSectionIdentifiers: [TextViewStatus] = []
    var snapshot = Snapshot()
    
    deinit {
        print("\(self) - deinit")
    }
}

extension TextViewListDiffableDataSource {
    func initSnapShot() {
        self.snapshot = Snapshot()
    }
    
    func apply(animated: Bool, section: [TextViewStatus] = []) {
        if !self.currentSectionIdentifiers.isEmpty {
            let reloadSections = self.snapshot.sectionIdentifiers.filter({ self.currentSectionIdentifiers.contains($0) })
            self.snapshot.reloadSections(reloadSections)
        }

        self.currentSectionIdentifiers = self.snapshot.sectionIdentifiers
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.apply(self.snapshot, animatingDifferences: animated)
        }
    }
}
