//
//  SwitchDelegate.swift
//


import Foundation

public protocol SwitchDelegate: AnyObject {
    
    func isOnValueChange(switch: MKSwitch, isOn: Bool)
    
}
