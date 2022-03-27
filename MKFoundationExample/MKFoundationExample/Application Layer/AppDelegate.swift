//
//  AppDelegate.swift
//


import UIKit
import MKFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.makeKeyAndVisible()
        
        NSSetUncaughtExceptionHandler { exception in
            print("Error Handling:\(exception)")
            print("Error Handling callStackSymbols: \(exception.callStackSymbols)")
        }
        self.startApplication()
        self.initLibrary()
        return true
    }
    
}

// MARK: - Application
extension AppDelegate {
    private func startApplication() {
        // MARK: - Coordinator
        self.appCoordinator = AppCoordinator(window: self.window!)

    }
}

// MARK: - Lib
extension AppDelegate {
    private func initLibrary() {
        MKFoundation.debugEnabled = true

    }
}
