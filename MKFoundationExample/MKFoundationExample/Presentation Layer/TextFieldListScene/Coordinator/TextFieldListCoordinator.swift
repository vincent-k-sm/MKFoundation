// 
// TextFieldListCoordinator.swift
// 

import Foundation

struct TextFieldListCoordinatorImplementation {
    
}

class TextFieldListCoordinator: BaseCoordinator {
    private let implementation: TextFieldListCoordinatorImplementation
    
    var inputs: TextFieldListViewModelInput!
    var actions: TextFieldListViewModelAction!

    init(implementation: TextFieldListCoordinatorImplementation) {
        self.implementation = implementation
    }
    
    deinit {
        print("\(self) -- deinit")
    }

    override func setInput() {
        
        self.inputs = TextFieldListViewModelInput(
        )
    }
    
    override func setActions() {
        self.actions = TextFieldListViewModelAction(
        )
    }
    
    override func start() {
        let vc = self.createViewController(input: self.inputs, actions: self.actions)
         self.pushVC(vc, completion: nil)

    }

}

protocol TextFieldListCoordinatorInjection {
    func createViewController(
        input: TextFieldListViewModelInput!,
        actions: TextFieldListViewModelAction!
    ) -> TextFieldListViewController
}

extension TextFieldListCoordinator: TextFieldListCoordinatorInjection {
    func createViewController(
        input: TextFieldListViewModelInput!,
        actions: TextFieldListViewModelAction!
    ) -> TextFieldListViewController {
        let viewModel = TextFieldListViewModel(input: inputs, actions: actions)
        let vc = TextFieldListViewController(viewModel: viewModel)
        return vc
    }
}

protocol TextFieldListCoordinatorAction {
    // MARK: Make Actions
}

extension TextFieldListCoordinator: TextFieldListCoordinatorAction {
    
}

