//
//  MKSelectBoxDelegate.swift
//


import Foundation

public protocol MKSelectBoxDelegate: AnyObject {
    
    func didSelected(_ selectBox: MKSelectBox)
    func didChangeStatus(_ selectBox: MKSelectBox, status: SelectBoxStatus)
}
