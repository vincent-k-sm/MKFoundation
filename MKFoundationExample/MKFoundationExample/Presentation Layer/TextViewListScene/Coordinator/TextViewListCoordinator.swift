// 
// TextViewListCoordinator.swift
// 

import Foundation

struct TextViewListCoordinatorImplementation {
    
}

class TextViewListCoordinator: BaseCoordinator {
    private let implementation: TextViewListCoordinatorImplementation
    
    var inputs: TextViewListViewModelInput!
    var actions: TextViewListViewModelAction!

    init(implementation: TextViewListCoordinatorImplementation) {
        self.implementation = implementation
    }
    
    deinit {
        print("\(self) -- deinit")
    }

    override func setInput() {
        
        self.inputs = TextViewListViewModelInput(
        )
    }
    
    override func setActions() {
        self.actions = TextViewListViewModelAction(
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
         self.pushVC(vc, completion: nil)

    }

}

protocol TextViewListCoordinatorInjection {
    func createViewController(
        input: TextViewListViewModelInput!,
        actions: TextViewListViewModelAction!
    ) -> TextViewListViewController
}

extension TextViewListCoordinator: TextViewListCoordinatorInjection {
    func createViewController(
        input: TextViewListViewModelInput!,
        actions: TextViewListViewModelAction!
    ) -> TextViewListViewController {
        let viewModel = TextViewListViewModel(input: inputs, actions: actions)
        let vc = TextViewListViewController(viewModel: viewModel)
        return vc
    }
}

protocol TextViewListCoordinatorAction {
    // MARK: Make Actions
}

extension TextViewListCoordinator: TextViewListCoordinatorAction {
    
}

