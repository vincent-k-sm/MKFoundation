//
//  ButtonListDiffableDataSource.swift
//


import Foundation
import UIKit
import MKFoundation

enum ButtonListSections: Int {
    case `default`
}

enum ButtonListCellTypes: Hashable {
    case item(type: ButtonTypes)
}

class ButtonListDiffableDataSource: UITableViewDiffableDataSource<ButtonListSections, ButtonListCellTypes> {
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<ButtonListSections, ButtonListCellTypes>
    
    var currentSectionIdentifiers: [ButtonListSections] = []
    var snapshot = Snapshot()
    
    deinit {
        print("\(self) - deinit")
    }
}

extension ButtonListDiffableDataSource {
    func initSnapShot() {
        self.snapshot = Snapshot()
    }
    
    func apply(animated: Bool, section: [ButtonListSections] = []) {
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
