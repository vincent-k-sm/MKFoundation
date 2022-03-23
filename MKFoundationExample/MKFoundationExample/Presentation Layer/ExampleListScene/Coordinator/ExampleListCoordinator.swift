// 
// ExampleListCoordinator.swift
// 

import Foundation
import UIKit

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
            moveToFoundationList: self.moveToFoundationList(type:)
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
        let options = TransitionOptions(
            direction: .fade,
            style: .easeIn,
            duration: .main
        )

        let nav = UINavigationController(rootViewController: vc)
        self.setRootVC(nav, options: options)
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
    func moveToFoundationList(type: FoundationTypes)
}

extension ExampleListCoordinator: ExampleListCoordinatorAction {
    func moveToFoundationList(type: FoundationTypes) {
        print(type.title)
    }
    
    
}

