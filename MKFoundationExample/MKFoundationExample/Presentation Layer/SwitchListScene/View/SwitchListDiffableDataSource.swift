//
//  SwitchListDiffableDataSource.swift
//


import Foundation
import UIKit
import MKFoundation

enum SwitchListSectionTypes: Int {
    case main
}

enum SwitchListCellTypes: Hashable, Equatable {
    case item(isOn: Bool, enabled: Bool, title: String)
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case let (.item(lv1, lv2, lv3), .item(rv1, rv2, rv3)):
                return lv1 == rv1
                && lv2 == rv2
                && lv3 == rv3
        }
        
    }
}

class SwitchListDiffableDataSource: UITableViewDiffableDataSource<SwitchListSectionTypes, SwitchListCellTypes> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<SwitchListSectionTypes, SwitchListCellTypes>
    
    var currentSectionIdentifiers: [SwitchListSectionTypes] = []
    var snapshot = Snapshot()
    
    deinit {
        print("\(self) - deinit")
    }
}

extension SwitchListDiffableDataSource {
    func initSnapShot() {
        self.snapshot = Snapshot()
    }
    
    func apply(animated: Bool, section: [SwitchListSectionTypes] = []) {
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
