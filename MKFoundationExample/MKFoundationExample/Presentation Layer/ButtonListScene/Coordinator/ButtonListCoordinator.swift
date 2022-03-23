// 
// ButtonListCoordinator.swift
// 

import Foundation

struct ButtonListCoordinatorImplementation {
    
}

class ButtonListCoordinator: BaseCoordinator {
    private let implementation: ButtonListCoordinatorImplementation
    
    var inputs: ButtonListViewModelInput!
    var actions: ButtonListViewModelAction!

    init(implementation: ButtonListCoordinatorImplementation) {
        self.implementation = implementation
    }
    
    deinit {
        print("\(self) -- deinit")
    }

    override func setInput() {
        
        self.inputs = ButtonListViewModelInput(
        )
    }
    
    override func setActions() {
        self.actions = ButtonListViewModelAction(
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
         self.pushVC(vc, completion: nil)

    }

}

protocol ButtonListCoordinatorInjection {
    func createViewController(
        input: ButtonListViewModelInput!,
        actions: ButtonListViewModelAction!
    ) -> ButtonListViewController
}

extension ButtonListCoordinator: ButtonListCoordinatorInjection {
    func createViewController(
        input: ButtonListViewModelInput!,
        actions: ButtonListViewModelAction!
    ) -> ButtonListViewController {
        let viewModel = ButtonListViewModel(input: inputs, actions: actions)
        let vc = ButtonListViewController(viewModel: viewModel)
        return vc
    }
}

protocol ButtonListCoordinatorAction {
    // MARK: Make Actions
}

extension ButtonListCoordinator: ButtonListCoordinatorAction {
    
}

