// 
// SwitchListViewModel.swift
// 

import Combine
import Foundation
import MKFoundation
import UIKit

struct SwitchListViewModelInput {
    
}

struct SwitchListViewModelAction {
    
}

class SwitchListViewModel: BaseViewModel<SwitchListViewModelInput, SwitchListViewModelAction> {
 
    // MARK: - Private Properties
    var cancellable: Set<AnyCancellable> = []
    var dataSource: SwitchListDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewModel()
        self.setEvent()
        self.setData()
        
    }
    
    private func prepareViewModel() {
     
    }
    
    deinit {
        print("\(self) - deinit")
    }
}

// MARK: - Event
extension SwitchListViewModel {
    private func setEvent() {
        
    }
}

// MARK: - Data
extension SwitchListViewModel {
    private func setData() {
        self.fetchItems()
    }
    
    private func fetchItems() {
        self.dataSource.initSnapShot()
    
        self.dataSource.snapshot.appendSections([.main])
        self.addItems()
        self.dataSource.apply(animated: false)
    }
    
    private func addItems() {
        var cells: [SwitchListCellTypes] = []
        cells.append(.item(isOn: true, enabled: true, title: "Is On + enable"))
        cells.append(.item(isOn: true, enabled: false, title: "Is On + disable"))
        cells.append(.item(isOn: false, enabled: true, title: "Is Off + enable"))
        cells.append(.item(isOn: false, enabled: false, title: "Is Off + disable"))
        
        self.dataSource.snapshot.appendItems(cells, toSection: .main)
    }
}

