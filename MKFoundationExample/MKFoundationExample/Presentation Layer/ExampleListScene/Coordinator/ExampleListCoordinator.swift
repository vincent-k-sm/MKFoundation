// 
// ExampleListCoordinator.swift
// 

import Foundation

struct ExampleListCoordinatorImplementation {
    
}

class ExampleListCoordinator: BaseCoordinator {
    private let implementation: ExampleListCoordinatorImplementation
    
    var inputs: ExampleListViewModelInput!
    var actions: ExampleListViewModelAction!

    init(implementation: ExampleListCoordinatorImplementation) {
        self.implementation = implementation
    }
    
    deinit {
        print("\(self) - deinit")
    }

    override func setInput() {
        
        self.inputs = ExampleListViewModelInput(
        )
    }
    
    override func setActions() {
        self.actions = ExampleListViewModelAction(
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
        self.setRootNavVC(vc)

    }

}

protocol ExampleListCoordinatorInjection {
    func createViewController(
        input: ExampleListViewModelInput!,
        actions: ExampleListViewModelAction!
    ) -> ExampleListViewController
}

extension ExampleListCoordinator: ExampleListCoordinatorInjection {
    func createViewController(
        input: ExampleListViewModelInput!,
        actions: ExampleListViewModelAction!
    ) -> ExampleListViewController {
        let viewModel = ExampleListViewModel(input: inputs, actions: actions)
        let vc = ExampleListViewController(viewModel: viewModel)
        return vc
    }
}

protocol ExampleListCoordinatorAction {
    // MARK: Make Actions
}

extension ExampleListCoordinator: ExampleListCoordinatorAction {
    
}

