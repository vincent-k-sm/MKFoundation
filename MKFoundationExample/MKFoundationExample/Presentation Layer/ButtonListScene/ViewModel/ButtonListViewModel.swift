// 
// ButtonListViewModel.swift
// 

import Combine
import Foundation
import MKFoundation

struct ButtonListViewModelInput {
    
}

struct ButtonListViewModelAction {
    
}

class ButtonListViewModel: BaseViewModel<ButtonListViewModelInput, ButtonListViewModelAction> {
 
    // MARK: - Private Properties
    var cancellable: Set<AnyCancellable> = []
    var dataSource: ButtonListDiffableDataSource!
    
    
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
extension ButtonListViewModel {
    private func setEvent() {
        
    }
}

// MARK: - Data
extension ButtonListViewModel {
    private func setData() {
        self.fetchItems()
    }
    
    private func fetchItems() {
        self.dataSource.initSnapShot()
        self.dataSource.snapshot.appendSections([.default])
        self.addItems()
        self.dataSource.apply(animated: false)
    }
    
    private func addItems() {
        var cells: [ButtonListCellTypes] = []
        ButtonTypes.allCases.forEach {
            cells.append(.item(type: $0))
        }
        self.dataSource.snapshot.appendItems(cells, toSection: .default)
    }
}

