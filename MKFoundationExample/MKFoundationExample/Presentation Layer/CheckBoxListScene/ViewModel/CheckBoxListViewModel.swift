// 
// CheckBoxListViewModel.swift
// 

import Combine
import Foundation
import MKFoundation
import UIKit

struct CheckBoxListViewModelInput {
    
}

struct CheckBoxListViewModelAction {
    
}

class CheckBoxListViewModel: BaseViewModel<CheckBoxListViewModelInput, CheckBoxListViewModelAction> {
 
    // MARK: - Private Properties
    var cancellable: Set<AnyCancellable> = []
    var dataSource: CheckBoxListDiffableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViewModel()
        self.setEvent()
        self.setData()
        
    }
    
    private func prepareViewModel() {
     
    }
    
    deinit {
        print("\(self) -- deinit")
    }
}

// MARK: - Event
extension CheckBoxListViewModel {
    private func setEvent() {
        
    }
}

// MARK: - Data
extension CheckBoxListViewModel {
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
        var cells: [CheckBoxListCellTypes] = []
        let optionA = MKCheckBoxOptions(
            text: "enabled + isOn",
            isEnabled: true,
            textColor: .text_primary,
            isOn: true
        )
        
        let optionB = MKCheckBoxOptions(
            text: "enabled + isOff",
            isEnabled: true,
            textColor: .text_primary,
            isOn: false
        )

        let optionC = MKCheckBoxOptions(
            text: "disabled + isOn",
            isEnabled: false,
            textColor: .text_primary,
            isOn: true
        )
        
        let optionD = MKCheckBoxOptions(
            text: "disabled + isOff",
            isEnabled: false,
            textColor: .text_primary,
            isOn: false
        )
        
        
        let optionArray = [optionA, optionB, optionC, optionD]
        
        let items = optionArray.map({ item -> CheckBoxListCellTypes in
            return .item(option: item)
        })
        cells.append(contentsOf: items)
        self.dataSource.snapshot.appendItems(cells, toSection: .main)
        
    }
}

