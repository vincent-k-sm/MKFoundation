//
//  MKSelectBoxDelegate.swift
//


import Foundation

public protocol MKSelectBoxDelegate: AnyObject {
    // Select box Selected
    /// - Parameter selectBox: The MKSelectBox that selectBox was called in
    func didSelected(_ selectBox: MKSelectBox)
    
    // Select box didChangeStatus
    /// - Parameter selectBox: The MKSelectBox that selectBox was called in
    /// - Parameter status: selectBox status - SelectBoxStatus
    func didChangeStatus(_ selectBox: MKSelectBox, status: SelectBoxStatus)
}
