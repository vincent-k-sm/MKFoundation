// 
// SwitchListCoordinator.swift
// 

import Foundation

struct SwitchListCoordinatorImplementation {
    
}

class SwitchListCoordinator: BaseCoordinator {
    private let implementation: SwitchListCoordinatorImplementation
    
    var inputs: SwitchListViewModelInput!
    var actions: SwitchListViewModelAction!

    init(implementation: SwitchListCoordinatorImplementation) {
        self.implementation = implementation
    }
    
    deinit {
        print("\(self) -- deiint")
    }

    override func setInput() {
        
        self.inputs = SwitchListViewModelInput(
        )
    }
    
    override func setActions() {
        self.actions = SwitchListViewModelAction(
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
        self.pushVC(vc, completion: nil)
        
    }

}

protocol SwitchListCoordinatorInjection {
    func createViewController(
        input: SwitchListViewModelInput!,
        actions: SwitchListViewModelAction!
    ) -> SwitchListViewController
}

extension SwitchListCoordinator: SwitchListCoordinatorInjection {
    func createViewController(
        input: SwitchListViewModelInput!,
        actions: SwitchListViewModelAction!
    ) -> SwitchListViewController {
        let viewModel = SwitchListViewModel(input: inputs, actions: actions)
        let vc = SwitchListViewController(viewModel: viewModel)
        return vc
    }
}

protocol SwitchListCoordinatorAction {
    // MARK: Make Actions
}

extension SwitchListCoordinator: SwitchListCoordinatorAction {
    
}

