//
//  AppCoordinator.swift
//


import UIKit

class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        
        self.window = window
        self.window.makeKeyAndVisible()
        super.init()
        self.start()
    }
   
    deinit {
        print("\(self) - deinit")
    }
    
    override func start() {
        self.moveToRootViewController()
    }

}

extension AppCoordinator {
    private func moveToRootViewController() {
        let impl = ExampleListCoordinatorImplementation()
        self.coordinate(to: .exampleList(impl))
    }
}
