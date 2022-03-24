//
//  SelectBoxListDiffableDataSource.swift
//


import Foundation
import UIKit
import MKFoundation

/// SelectBoxStatus
//enum SelectBoxListSections: Int, CaseIterable {
//    case normal
//    case focused
//    case activate
//    case error
//    case disabled
//
//    var title: String {
//        return "\(self)"
//    }
//}

enum SelectBoxListCellTypes: Hashable, Equatable {
    case item(option: MKSelectBoxOptions, status: SelectBoxStatus)
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case let (.item(lv1, lv2), .item(rv1, rv2)):
                return lv1 == rv1 && lv2 == rv2
        }
        
    }
}

class SelectBoxListDiffableDataSource: UITableViewDiffableDataSource<SelectBoxStatus, SelectBoxListCellTypes> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<SelectBoxStatus, SelectBoxListCellTypes>
    
    var currentSectionIdentifiers: [SelectBoxStatus] = []
    var snapshot = Snapshot()
    
    deinit {
        print("\(self) - deinit")
    }
}

extension SelectBoxListDiffableDataSource {
    func initSnapShot() {
        self.snapshot = Snapshot()
    }
    
    func apply(animated: Bool, section: [SelectBoxStatus] = []) {
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
