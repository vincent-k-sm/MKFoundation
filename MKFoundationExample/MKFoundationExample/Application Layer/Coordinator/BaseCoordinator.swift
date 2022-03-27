//
//  BaseCoordinator.swift
//


import UIKit
import MKFoundation

protocol Coordinator: AnyObject {
    
    func start()
    func coordinate(to coordinator: FlowType)
    func setActions()
    func setInput()
}

class BaseCoordinator: Coordinator {
    
    init() {
        
    }
    
    deinit {
        print("BaseCoordinator - deinit")
    }
    
    func start() {
        fatalError("Start method should be implemented.")
    }
    
    func setActions() {
        fatalError("setActions method should be implemented.")
        // action should be implemented
    }
    
    func setInput() {
        fatalError("setInput method should be implemented.")
        // action should be implemented
    }
    
    func coordinate(to coordinator: FlowType) {
        let newCoordinator = self.flow(to: coordinator)
        self.coordinate(to: newCoordinator)
    }
    
    private func coordinate(to coordinator: Coordinator) {
        coordinator.setActions()
        coordinator.setInput()
        coordinator.start()
    }
    
}

// MARK: - Presentation - Pop
extension Coordinator {
    func dismiss() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            guard let topVC = UIApplication.topViewController() else { return }
            if let nav = topVC.navigationController {
                nav.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func popAskViewCotroller() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let topVC = UIApplication.topViewController() else { return }
            topVC.dismiss(animated: true, completion: {
                self.pop()
            })
        }
    }
        
    func dismissClosure(completion: @escaping (Bool) -> Void ) {
        DispatchQueue.main.async {
            guard let topVC = UIApplication.topViewController() else { return }
            topVC.dismiss(animated: true, completion: {
                completion(true)
            })
        }
        
    }
    
    func removeNavigationStack() {
        DispatchQueue.main.async {
            
            guard let topVC = UIApplication.topViewController() else { return }
            guard let navigationController = topVC.navigationController else {
                return
            }
            
            let viewControllers = navigationController.viewControllers
            
            if viewControllers.count > 2 {
                if let first = viewControllers.first, let last = viewControllers.last {
                    let newViewControllers: [UIViewController] = [first, last]
                    navigationController.viewControllers = newViewControllers
                }
            }
        }
        
    }
    
    func pop(dissolve: Bool = false, count: Int = 1) {
//        DispatchQueue.main.async { [weak self] in
//            guard let self = self else { return }
            guard let topVC = UIApplication.topViewController() else { return }
            guard let navigationController = topVC.navigationController else {
                topVC.dismiss(animated: true, completion: nil)
                return
            }
            let viewControllers = navigationController.viewControllers
            if count > 1 {
                
                let index = count + 1
                
                /// stack 에 있는 vc 카운팅
                if viewControllers.count >= index {
                    if dissolve {
                        let option = TransitionOptions(direction: .fade, style: .linear, duration: .main)
                        navigationController.view.layer.add(option.animation, forKey: kCATransition)
                    }
                    navigationController.popToViewController(viewControllers[viewControllers.count - index], animated: !dissolve)
                }
                else {
                    print("Pop Count does not exist\nControllers Count : \(viewControllers.count)\nRequest: \(count)\n")
                    fatalError("Pop Count does not exist")
                }
            }
            else {
                if dissolve {
                    self.popDissolve(navigationController: navigationController)
                }
                else {
                    if navigationController.viewControllers.count <= 1 {
                        navigationController.dismiss(animated: true, completion: nil)
                    }
                    else {
                        navigationController.popViewController(animated: true)
                    }
                    
                }
                
            }
//        }
        
    }
    
    func popToRoot(completion: @escaping (Bool) -> Void ) {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            guard let topVC = UIApplication.topViewController() else { return }
            guard let navigationController = topVC.navigationController else {
                completion(false)
                return
            }
            navigationController.popToRootViewController(animated: false)
            completion(true)
        }
        
    }
    
    private func popDissolve(navigationController: UINavigationController) {
//        guard let window = UIWindow.key else { return }

        let option = TransitionOptions(direction: .fade, style: .linear, duration: .main)
        navigationController.view.layer.add(option.animation, forKey: kCATransition)
        if navigationController.viewControllers.count <= 1 {
            navigationController.dismiss(animated: false, completion: nil)
        }
        else {
            navigationController.popViewController(animated: false)
        }
        
    }
}

// MARK: - present
extension Coordinator {
    func presentVcOveral(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        guard let window = UIWindow.key else { return }
        let nav = UINavigationController(rootViewController: controller)
//        controller.navigationController?.setNavigationBarHidden(true, animated: false)
        controller.navigationController?.interactivePopGestureRecognizer!.delegate = controller as? UIGestureRecognizerDelegate
        controller.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
        controller.view.clipsToBounds = true
        
        window.layer.add(options.animation, forKey: kCATransition)
        nav.definesPresentationContext = false
        nav.modalPresentationStyle = .overCurrentContext
        
        if options.direction == .fade {
            
            nav.modalTransitionStyle = .crossDissolve
        }
        
        guard let topVC = UIApplication.topViewController() else {
            print("Empty Top VC")
            return
        }
        topVC.present(nav, animated: true, completion: nil)
        
    }
    
    func presentVCFromTabbar(_ controller: UIViewController, overalType: OveralType = .fullscreen, options: TransitionOptions = TransitionOptions()) {
        guard let window = UIWindow.key else { return }
        let nav = UINavigationController(rootViewController: controller)
//        controller.navigationController?.setNavigationBarHidden(true, animated: false)
        controller.navigationController?.interactivePopGestureRecognizer!.delegate = controller as? UIGestureRecognizerDelegate
        controller.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
        controller.view.clipsToBounds = true
        
        window.layer.add(options.animation, forKey: kCATransition)
        switch overalType {
        
        case .fullscreen:
            nav.definesPresentationContext = false
            nav.modalPresentationStyle = .fullScreen

        case .overal:
            nav.definesPresentationContext = false
            nav.modalPresentationStyle = .overCurrentContext
        }
        
        if options.direction == .fade {
            
            nav.modalTransitionStyle = .crossDissolve
        }
        
        guard let window = UIWindow.key else { return }

        guard let tabbarController = window.rootViewController as? UITabBarController else {
            fatalError("no UITabBarController")
        }

        tabbarController.present(nav, animated: true, completion: nil)
        
    }
    
    func presentVC(_ controller: UIViewController, type: UIModalPresentationStyle) {
        controller.modalPresentationStyle = type// .fullScreen
        guard let topVC = UIApplication.topViewController() else {
            print("Empty Top VC")
            return
        }
        topVC.present(controller, animated: true, completion: nil)
        
    }
    
    /// From Top : 최 상위 View Controller
    func pushVC(_ controller: UIViewController, options: TransitionOptions = TransitionOptions(), completion: (() -> Void)?) {
        DispatchQueue.main.async {
            
            guard let window = UIWindow.key else { return }
            guard let topVC = UIApplication.topViewController() else { return }
            var navigationController: UINavigationController?
            if let nav = topVC.navigationController {
                navigationController = nav
            }
            else {
                if let rootNav = window.rootViewController as? UINavigationController {
                    navigationController = rootNav
                }
                else {
                    if let rootTabbar = window.rootViewController as? UITabBarController {
                        if let nav = rootTabbar.selectedViewController as? UINavigationController {
                            navigationController = nav
                        }
                        else {
                            navigationController = rootTabbar.children.first(where: { $0.isKind(of: UINavigationController.self) }) as? UINavigationController
                        }
                        
                    }
                }
            }
            guard let navController = navigationController else {
                fatalError("no UINavigationController : pushed to \(controller)")
            }

            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            controller.navigationController?.interactivePopGestureRecognizer!.delegate = controller as? UIGestureRecognizerDelegate
            
            if options.direction == .fade {
                controller.modalTransitionStyle = .crossDissolve
                navController.view.layer.add(options.animation, forKey: kCATransition)
                navController.pushViewController(controller, animated: false)
                controller.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
                CATransaction.commit()
            }
            else {
                DispatchQueue.main.async {
                    navController.pushViewController(controller, animated: true)
                    controller.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
                    CATransaction.commit()
                }
                
            }
        }
        
    }
}

// MARK: - Present root
extension Coordinator {
    /**Splash VC 등 단일 페이지에서 이루어지는 항목에만 사용하길 권장합니다*/
    func setRootVC(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        guard let window = UIWindow.key else { return }
        
        window.layer.add(options.animation, forKey: kCATransition)
        window.rootViewController = controller
        window.makeKeyAndVisible()

    }
    
    func setRootNavVC(_ controller: UIViewController, setNavHidden: Bool = true, options: TransitionOptions = TransitionOptions()) {
        guard let window = UIWindow.key else { return }
        
        let currentRoot = window.rootViewController
        if currentRoot != nil && options.direction != .fade {
            let width = currentRoot?.view.frame.size.width
            let height = currentRoot?.view.frame.size.height

            var previousFrame: CGRect?
            var nextFrame: CGRect?

            switch options.direction {
            case .toLeft:
                previousFrame = CGRect(x: -width!+1.0, y: 0.0, width: width!, height: height!)
                nextFrame = CGRect(x: width!, y: 0.0, width: width!, height: height!)

            case .toRight:
                previousFrame = CGRect(x: width!-1.0, y: 0.0, width: width!, height: height!)
                nextFrame = CGRect(x: -width!, y: 0.0, width: width!, height: height!)

            case .toTop:
                previousFrame = CGRect(x: 0.0, y: height!-1.0, width: width!, height: height!)
                nextFrame = CGRect(x: 0.0, y: -height!+1.0, width: width!, height: height!)

            case .toBottom:
                previousFrame = CGRect(x: 0.0, y: height!+1.0, width: width!, height: height!)
                nextFrame = CGRect(x: 0.0, y: height!-1.0, width: width!, height: height!)

            case .fade:
                break

            }
            controller.view.frame = previousFrame!
            
            window.addSubview(controller.view)

            UIView.animate(
                withDuration: options.duration.rawValue,
                animations: {
                    controller.view.frame = (currentRoot?.view.frame)!
                    currentRoot?.view.frame = nextFrame!
                    
                }, completion: { (_) in
                    
                    let nav = UINavigationController(rootViewController: controller)
                    
                    window.rootViewController = nav
                    //                            controller.navigationController?.setNavigationBarHidden(false, animated: false)
                    controller.navigationController?.interactivePopGestureRecognizer!.delegate = controller as? UIGestureRecognizerDelegate
                    controller.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
                    controller.view.clipsToBounds = true
                    //                            nav.navigationBar.isHidden = setNavHidden
                    
                })
        
        }
        else {
            
            // Make animation
            window.layer.add(options.animation, forKey: kCATransition)

            let nav = UINavigationController(rootViewController: controller)
            window.rootViewController = nav

//            controller.navigationController?.setNavigationBarHidden(false, animated: true)
            controller.navigationController?.interactivePopGestureRecognizer!.delegate = controller as? UIGestureRecognizerDelegate
            controller.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
            controller.view.clipsToBounds = true
            nav.navigationBar.isHidden = setNavHidden

        }
    }
}

enum OveralType {
    case fullscreen // fill
    case overal // cover
}

struct TransitionOptions {
    // Transition Options
    var direction: TransitionOptions.Direction     = .toRight
    var style: TransitionOptions.Curve             = .linear
    var duration: TransitionOptions.Duration       = .main
    
    internal var animation: CATransition {
        let transition            = self.direction.transition()
        transition.duration       = self.duration.rawValue
        transition.timingFunction = self.style.function
        return transition
    }
    
    init(direction: Direction = .toRight, style: Curve = .linear, duration: Duration = .main) {
        self.direction = direction
        self.style     = style
        self.duration  = duration
    }
    enum Curve {
        case linear
        case easeIn
        case easeOut
        case easeInOut
        
        internal var function: CAMediaTimingFunction {
            let key: String!
            switch self {
            case .linear:        key = CAMediaTimingFunctionName.linear.rawValue
            case .easeIn:        key = CAMediaTimingFunctionName.easeIn.rawValue
            case .easeOut:        key = CAMediaTimingFunctionName.easeOut.rawValue
            case .easeInOut:    key = CAMediaTimingFunctionName.easeInEaseOut.rawValue
            }
            return CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: key!))
        }
    }
    
    // Direction of the animation
    enum Direction {
       case fade
       case toTop
       case toBottom
       case toLeft
       case toRight
       
       /// Return the associated transition
       ///
       /// - Returns: transition
       internal func transition() -> CATransition {
           let transition = CATransition()
           transition.type = CATransitionType.push
           switch self {
           case .fade:
               transition.type = CATransitionType.fade
               transition.subtype = nil

           case .toLeft:
               transition.subtype = CATransitionSubtype.fromLeft

           case .toRight:
               transition.subtype = CATransitionSubtype.fromRight

           case .toTop:
               transition.subtype = CATransitionSubtype.fromTop

           case .toBottom:
               transition.subtype = CATransitionSubtype.fromBottom
           }
           return transition
       }
   }
    
    enum Duration: TimeInterval {
        case main = 0.3
    }
    
}
