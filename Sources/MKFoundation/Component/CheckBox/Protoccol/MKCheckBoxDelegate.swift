//
//  MKCheckBoxDelegate.swift
//


import Foundation

public protocol MKCheckBoxDelegate: AnyObject {
    
    func didSelected(_ selectBox: MKCheckBox)
    func didChangeStatus(_ selectBox: MKCheckBox, status: Bool)
}
