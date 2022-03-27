// 
// TextViewListViewModel.swift
// 

import Combine
import Foundation
import MKFoundation
import UIKit

struct TextViewListViewModelInput {
    
}

struct TextViewListViewModelAction {
    
}

class TextViewListViewModel: BaseViewModel<TextViewListViewModelInput, TextViewListViewModelAction> {
 
    // MARK: - Private Properties
    var cancellable: Set<AnyCancellable> = []
    var dataSource: TextViewListDiffableDataSource!
    
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
extension TextViewListViewModel {
    private func setEvent() {
        
    }
}

// MARK: - Data
extension TextViewListViewModel {
    private func setData() {
        self.fetchItems()
    }
    
    private func fetchItems() {
        self.dataSource.initSnapShot()
        
        TextViewStatus.allCases.forEach { status in
            self.dataSource.snapshot.appendSections([status])
            self.addItems(status: status)
        }
        
        self.dataSource.apply(animated: false)
    }
    
    private func addItems(status: TextViewStatus) {
        var cells: [TextViewListCellTypes] = []
        let optionA = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            title: nil,
            helperText: nil
        )
        
        let optionB = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            title: "Title",
            helperText: nil
        )
        
        let optionC = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            title: nil,
            helperText: "description for TextView"
        )
        
        let optionD = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            title: "Title With Description",
            helperText: "description for TextView"
        )
        
        let optionE = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            limitCount: 100,
            autoLimitCountErrorMessage: nil,
            title: "Title With Description + Counter",
            helperText: "description for TextView",
            counter: true
        )
        
        let optionF = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            limitCount: 10,
            autoLimitCountErrorMessage: "Text is Limitted",
            title: "Title + Counter + Limit Description",
            helperText: "description for TextView",
            counter: true
        )
        
        let optionH = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            limitCount: 10,
            autoLimitCountErrorMessage: "Text is Limitted",
            title: "Title + Counter + Limit Description + Done",
            helperText: "description for TextView",
            counter: true,
            doneAccessory: true,
            clearAccessory: false
        )
        
        let optionI = MKTextViewOptions(
            inputType: .outLine,
            placeHolder: "TextView PlaceHolder",
            limitCount: 10,
            autoLimitCountErrorMessage: "Text is Limitted",
            title: "Title + Counter + Limit Description + Clear",
            helperText: "description for TextView",
            counter: true,
            doneAccessory: true,
            clearAccessory: true
        )
        
        let optionArray = [optionA, optionB, optionC, optionD, optionE, optionF, optionH, optionI]
        optionArray.forEach { option in
            cells.append(.item(option: option, status: status ))
        }
        self.dataSource.snapshot.appendItems(cells, toSection: status)
    
    }
}

