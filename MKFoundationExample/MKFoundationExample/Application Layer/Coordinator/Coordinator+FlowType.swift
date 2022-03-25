//
//  Coordinator+FlowType.swift
//


import Foundation

enum FlowType{
    case exampleList(_ implementation: ExampleListCoordinatorImplementation)
    case buttonList(_ implementation: ButtonListCoordinatorImplementation)
    case selectBoxList(_ implementation: SelectBoxListCoordinatorImplementation)
    case textfieldList(_ implementation: TextFieldListCoordinatorImplementation)
}

extension BaseCoordinator {
    func flow(to flow: FlowType) -> BaseCoordinator {
        switch flow {
            case let .exampleList(impl):
                return ExampleListCoordinator(implementation: impl)
                
            case let .buttonList(impl):
                return ButtonListCoordinator(implementation: impl)
                
            case let .selectBoxList(impl):
                return SelectBoxListCoordinator(implementation: impl)
                
            case let .textfieldList(impl):
                return TextFieldListCoordinator(implementation: impl)
        }
    }
}
