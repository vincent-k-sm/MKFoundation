//
//  BaseViewController.swift
//


import Foundation
import UIKit

enum BarStyle {
    case white
    case dark
}

protocol BaseViewControllerProtocol: AnyObject {
    associatedtype T
    
    init(viewModel: T)
}

class BaseViewController<U>: UIViewController, BaseViewControllerProtocol, UIScrollViewDelegate {
    
    typealias T = U
    
    var viewModel: T
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(viewModel: U) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private var barStyle: UIStatusBarStyle = .default {
        willSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        print("\(self) - deinit")
    }
    
  
    
}

// MARK: - Appearance
extension BaseViewController {
    private struct Appearance {
        //
    }
    
    public func setStatusBarColor(_ style: BarStyle) {
        switch style {
            case .dark:
                
                self.navigationController?.navigationBar.barStyle = .default
                if #available(iOS 13.0, *) {
                    self.barStyle = .lightContent
                    self.navigationController?.navigationBar.overrideUserInterfaceStyle = .light
                    self.navigationController?.overrideUserInterfaceStyle = .light
                    self.overrideUserInterfaceStyle = .light
                }
                
            case .white:
                
                self.navigationController?.navigationBar.barStyle = .black
                if #available(iOS 13.0, *) {
                    self.barStyle = .darkContent
                    self.navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
                    self.navigationController?.overrideUserInterfaceStyle = .dark
                    self.overrideUserInterfaceStyle = .dark
                }
        }

    }
}

// MARK: - Statusbar
extension BaseViewController {
    public func setStatusBarBackgroundColor(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let statusBarBgView =  UIView()
            let tag = 101011
            statusBarBgView.tag = tag
            
            guard let window = UIWindow.key else { return }
            
            guard let statusBarManager = window.windowScene?.statusBarManager else { return }
            
            statusBarBgView.backgroundColor = color
            statusBarBgView.frame = statusBarManager.statusBarFrame
            if let currentStatusBar = window.viewWithTag(tag) {
                currentStatusBar.removeFromSuperview()
            }
            window.addSubview(statusBarBgView)
        }
    }

}
