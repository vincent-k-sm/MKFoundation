//
//  CheckBoxListDiffableDataSource.swift
//


import Foundation
import UIKit
import MKFoundation

enum CheckBoxListSectionTypes: Int {
    case main
}

enum CheckBoxListCellTypes: Hashable, Equatable {
    case item(option: MKCheckBoxOptions)
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case let (.item(lv1), .item(rv1)):
                return lv1 == rv1
        }
        
    }
}

class CheckBoxListDiffableDataSource: UITableViewDiffableDataSource<CheckBoxListSectionTypes, CheckBoxListCellTypes> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<CheckBoxListSectionTypes, CheckBoxListCellTypes>
    
    var currentSectionIdentifiers: [CheckBoxListSectionTypes] = []
    var snapshot = Snapshot()
    
    deinit {
        print("\(self) - deinit")
    }
}

extension CheckBoxListDiffableDataSource {
    func initSnapShot() {
        self.snapshot = Snapshot()
    }
    
    func apply(animated: Bool, section: [CheckBoxListSectionTypes] = []) {
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
