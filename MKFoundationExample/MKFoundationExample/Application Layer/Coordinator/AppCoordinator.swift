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
        self.moveToSplashViewController()
    }

}

extension AppCoordinator {
    private func moveToSplashViewController() {
//        let impl = SplashCoordinatorImplementaion()
//        self.coordinate(to: .splash(impl))
        
    }
}
