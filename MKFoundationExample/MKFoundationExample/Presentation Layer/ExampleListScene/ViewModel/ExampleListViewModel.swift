// 
// ExampleListViewModel.swift
// 

import Foundation

struct ExampleListViewModelInput {
    
}

struct ExampleListViewModelAction {
    
}

class ExampleListViewModel: BaseViewModel<ExampleListViewModelInput, ExampleListViewModelAction> {
 
    // MARK: - Private Properties
    
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
extension ExampleListViewModel {
    private func setEvent() {
        
    }
}

// MARK: - Data
extension ExampleListViewModel {
    private func setData() {
        
    }
}

