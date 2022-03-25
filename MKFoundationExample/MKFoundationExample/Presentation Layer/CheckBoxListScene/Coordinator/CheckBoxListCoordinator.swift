// 
// CheckBoxListCoordinator.swift
// 

import Foundation

struct CheckBoxListCoordinatorImplementation {
    
}

class CheckBoxListCoordinator: BaseCoordinator {
    private let implementation: CheckBoxListCoordinatorImplementation
    
    var inputs: CheckBoxListViewModelInput!
    var actions: CheckBoxListViewModelAction!

    init(implementation: CheckBoxListCoordinatorImplementation) {
        self.implementation = implementation
    }
    
    deinit {
        print("\(self) -- deinit")
    }

    override func setInput() {
        
        self.inputs = CheckBoxListViewModelInput(
        )
    }
    
    override func setActions() {
        self.actions = CheckBoxListViewModelAction(
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
        self.pushVC(vc, completion: nil)
        
    }

}

protocol CheckBoxListCoordinatorInjection {
    func createViewController(
        input: CheckBoxListViewModelInput!,
        actions: CheckBoxListViewModelAction!
    ) -> CheckBoxListViewController
}

extension CheckBoxListCoordinator: CheckBoxListCoordinatorInjection {
    func createViewController(
        input: CheckBoxListViewModelInput!,
        actions: CheckBoxListViewModelAction!
    ) -> CheckBoxListViewController {
        let viewModel = CheckBoxListViewModel(input: inputs, actions: actions)
        let vc = CheckBoxListViewController(viewModel: viewModel)
        return vc
    }
}

protocol CheckBoxListCoordinatorAction {
    // MARK: Make Actions
}

extension CheckBoxListCoordinator: CheckBoxListCoordinatorAction {
    
}

