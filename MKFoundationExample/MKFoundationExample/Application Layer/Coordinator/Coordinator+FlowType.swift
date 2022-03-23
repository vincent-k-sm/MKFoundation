//
//  Coordinator+FlowType.swift
//


import Foundation

enum FlowType{
    case exampleList(_ implementation: ExampleListCoordinatorImplementation)
}

extension BaseCoordinator {
    func flow(to flow: FlowType) -> BaseCoordinator {
        switch flow {
            case let .exampleList(impl):
                return ExampleListCoordinator(implementation: impl)
        }
    }
}
