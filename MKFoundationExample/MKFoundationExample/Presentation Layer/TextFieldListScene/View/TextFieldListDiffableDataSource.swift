//
//  TextFieldListDiffableDataSource.swift
//


import Foundation
import UIKit
import MKFoundation

enum TextFieldListCellTypes: Hashable, Equatable {
    case item(option: MKTextFieldOptions, status: TextFieldStatus)
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case let (.item(lv1, lv2), .item(rv1, rv2)):
                return lv1 == rv1 && lv2 == rv2
        }
        
    }
}

class TextFieldListDiffableDataSource: UITableViewDiffableDataSource<TextFieldStatus, TextFieldListCellTypes> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<TextFieldStatus, TextFieldListCellTypes>
    
    var currentSectionIdentifiers: [TextFieldStatus] = []
    var snapshot = Snapshot()
    
    deinit {
        print("\(self) - deinit")
    }
}

extension TextFieldListDiffableDataSource {
    func initSnapShot() {
        self.snapshot = Snapshot()
    }
    
    func apply(animated: Bool, section: [TextFieldStatus] = []) {
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
