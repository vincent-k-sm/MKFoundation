//
//  ExampleListViewController+Datasource.swift
//

import Foundation
import UIKit

enum ExampleListSections: Int {
    case `default`
}

enum ExampleListCellTypes: Hashable {
    case item(foundation: FoundationTypes)
}

class ExampleListDiffableDataSource: UITableViewDiffableDataSource<ExampleListSections, ExampleListCellTypes> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<ExampleListSections, ExampleListCellTypes>
    
    var currentSectionIdentifiers: [ExampleListSections] = []
    var snapshot = Snapshot()
    
    
    deinit {
        print("\(self) - deinit")
    }
}

extension ExampleListDiffableDataSource {
    func initSnapShot() {
        self.snapshot = Snapshot()
    }
    
    func apply(animated: Bool, section: [ExampleListSections] = []) {
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
