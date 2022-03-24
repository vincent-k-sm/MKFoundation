// 
// SelectBoxListCoordinator.swift
// 

import Foundation

struct SelectBoxListCoordinatorImplementation {
    
}

class SelectBoxListCoordinator: BaseCoordinator {
    private let implementation: SelectBoxListCoordinatorImplementation
    
    var inputs: SelectBoxListViewModelInput!
    var actions: SelectBoxListViewModelAction!

    init(implementation: SelectBoxListCoordinatorImplementation) {
        self.implementation = implementation
    }
    
    deinit {
        print("\(self) - deinit")
    }

    override func setInput() {
        
        self.inputs = SelectBoxListViewModelInput(
        )
    }
    
    override func setActions() {
        self.actions = SelectBoxListViewModelAction(
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
        self.pushVC(vc, completion: nil)

    }

}

protocol SelectBoxListCoordinatorInjection {
    func createViewController(
        input: SelectBoxListViewModelInput!,
        actions: SelectBoxListViewModelAction!
    ) -> SelectBoxListViewController
}

extension SelectBoxListCoordinator: SelectBoxListCoordinatorInjection {
    func createViewController(
        input: SelectBoxListViewModelInput!,
        actions: SelectBoxListViewModelAction!
    ) -> SelectBoxListViewController {
        let viewModel = SelectBoxListViewModel(input: inputs, actions: actions)
        let vc = SelectBoxListViewController(viewModel: viewModel)
        return vc
    }
}

protocol SelectBoxListCoordinatorAction {
    // MARK: Make Actions
}

extension SelectBoxListCoordinator: SelectBoxListCoordinatorAction {
    
}

