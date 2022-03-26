//
//  Coordinator+FlowType.swift
//


import Foundation

enum FlowType{
    case exampleList(_ implementation: ExampleListCoordinatorImplementation)
    case buttonList(_ implementation: ButtonListCoordinatorImplementation)
    case selectBoxList(_ implementation: SelectBoxListCoordinatorImplementation)
    case textfieldList(_ implementation: TextFieldListCoordinatorImplementation)
    case textViewList(_ implementation: TextViewListCoordinatorImplementation)
    case switchList(_ implementation: SwitchListCoordinatorImplementation)
    case checkBoxList(_ implementation: CheckBoxListCoordinatorImplementation)
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
                
            case let .textViewList(impl):
                return TextViewListCoordinator(implementation: impl)
                
            case let .switchList(impl):
                return SwitchListCoordinator(implementation: impl)
                
            case let .checkBoxList(impl):
                return CheckBoxListCoordinator(implementation: impl)
        }
    }
}
