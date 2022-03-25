// 
// TextFieldListViewModel.swift
// 

import Combine
import Foundation
import MKFoundation
import UIKit

struct TextFieldListViewModelInput {
    
}

struct TextFieldListViewModelAction {
    
}

class TextFieldListViewModel: BaseViewModel<TextFieldListViewModelInput, TextFieldListViewModelAction> {
 
    // MARK: - Private Properties
    var cancellable: Set<AnyCancellable> = []
    var dataSource: TextFieldListDiffableDataSource!
    
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
extension TextFieldListViewModel {
    private func setEvent() {
        
    }
    
}

// MARK: - Data
extension TextFieldListViewModel {
    private func setData() {
        self.fetchItems()
    }
    
    private func fetchItems() {
        self.dataSource.initSnapShot()
        
        TextFieldStatus.allCases.forEach { status in
            self.dataSource.snapshot.appendSections([status])
            self.addItems(status: status)
        }
        
        self.dataSource.apply(animated: false)
    }
    
    private func addItems(status: TextFieldStatus) {
        var cells: [TextFieldListCellTypes] = []
        let optionA = MKTextFieldOptions(
            inputType: .outLine,
            placeHolder: "TextField PlaceHolder",
            title: nil,
            helperText: nil
        )
        
        let optionB = MKTextFieldOptions(
            inputType: .outLine,
            placeHolder: "TextField PlaceHolder",
            title: "Title",
            helperText: nil
        )
        
        let optionC = MKTextFieldOptions(
            inputType: .outLine,
            placeHolder: "TextField PlaceHolder",
            title: nil,
            helperText: "description for TextField"
        )
        
        let optionD = MKTextFieldOptions(
            inputType: .outLine,
            placeHolder: "TextField PlaceHolder",
            title: "Title With Description",
            helperText: "description for TextField"
        )
        
        let optionE = MKTextFieldOptions(
            inputType: .outLine,
            placeHolder: "TextField PlaceHolder",
            limitCount: 100,
            autoLimitCountErrorMessage: nil,
            title: "Title With Description + Counter",
            helperText: "description for TextField",
            leadingIcon: UIImage(named: "ic_search") ?? nil,
            counter: true
        )
        
        let optionF = MKTextFieldOptions(
            inputType: .outLine,
            placeHolder: "TextField PlaceHolder",
            limitCount: 10,
            autoLimitCountErrorMessage: "Text is Limitted",
            title: "Title + Counter + Limit Description",
            helperText: "description for TextField",
            leadingIcon: UIImage(named: "ic_search") ?? nil,
            counter: true
        )
        
        let optionArray = [optionA, optionB, optionC, optionD, optionE, optionF]
        optionArray.forEach { option in
            cells.append(.item(option: option, status: status ))
        }
        self.dataSource.snapshot.appendItems(cells, toSection: status)
    
    }
}

