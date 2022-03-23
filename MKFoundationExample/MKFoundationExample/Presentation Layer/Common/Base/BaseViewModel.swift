//
//  BaseViewModel.swift
//


import Foundation

protocol BaseViewModelProtocol: AnyObject {
    associatedtype T
    associatedtype A
    init(input: T, actions: A)
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

class BaseViewModel<U, A>: NSObject, BaseViewModelProtocol {
    typealias T = U
    typealias E = A
    
    var input: T
    let actions: E
    
    convenience override init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(input: U, actions: A) {
        self.input = input
        self.actions = actions
    }
    
    func viewDidLoad() {
        prepareInput()
    }
    
    func viewWillAppear() {
        //
    }
    
    func viewDidAppear() {
        //
    }
    
    func prepareInput() {
        //
    }
    
    deinit {
        print("\(self) - deinit")
    }
}
