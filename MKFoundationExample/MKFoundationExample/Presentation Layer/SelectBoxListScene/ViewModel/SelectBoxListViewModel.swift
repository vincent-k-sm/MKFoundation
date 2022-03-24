// 
// SelectBoxListViewModel.swift
// 

import Combine
import Foundation
import MKFoundation

struct SelectBoxListViewModelInput {
    
}

struct SelectBoxListViewModelAction {
    
}

class SelectBoxListViewModel: BaseViewModel<SelectBoxListViewModelInput, SelectBoxListViewModelAction> {
 
    // MARK: - Private Properties
    var cancellable: Set<AnyCancellable> = []
    var dataSource: SelectBoxListDiffableDataSource!
    
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
extension SelectBoxListViewModel {
    private func setEvent() {
        
    }
}

// MARK: - Data
extension SelectBoxListViewModel {
    private func setData() {
        self.fetchItems()
    }
    
    private func fetchItems() {
        self.dataSource.initSnapShot()
        
//        self.dataSource.snapshot.appendSections(SelectBoxStatus.allCases)
        
        SelectBoxStatus.allCases.forEach { status in
            self.dataSource.snapshot.appendSections([status])
            self.addItems(status: status)
        }
        
        self.dataSource.apply(animated: false)
    }
    
    private func addItems(status: SelectBoxStatus) {
        var cells: [SelectBoxListCellTypes] = []
        let optionA = MKSelectBoxOptions(
            inputType: .outLine,
            placeHolder: "Select box PlaceHolder",
            title: nil,
            helperText: nil
        )
        
        let optionB = MKSelectBoxOptions(
            inputType: .outLine,
            placeHolder: "Select box PlaceHolder",
            title: "Title",
            helperText: nil
        )
        
        let optionC = MKSelectBoxOptions(
            inputType: .outLine,
            placeHolder: "Select box PlaceHolder",
            title: nil,
            helperText: "description for select box"
        )
        
        let optionD = MKSelectBoxOptions(
            inputType: .outLine,
            placeHolder: "Select box PlaceHolder",
            title: "Title With Description",
            helperText: "description for select box"
        )
        
        
        let optionArray = [optionA, optionB, optionC, optionD]
        optionArray.forEach { option in
            cells.append(.item(option: option, status: status ))
        }
        self.dataSource.snapshot.appendItems(cells, toSection: status)
        
        
    }
}

