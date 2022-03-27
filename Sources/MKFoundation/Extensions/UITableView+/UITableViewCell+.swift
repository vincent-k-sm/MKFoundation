//
//  UITableViewCell+.swift
//


import Foundation
import UIKit

public extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                let newSuperview = table?.superview
                table = newSuperview
            }
            return table as? UITableView
        }
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
    
}
