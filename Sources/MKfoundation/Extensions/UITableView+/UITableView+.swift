//
//  UITableView+.swift
//


import Foundation
import UIKit

public extension UITableView {
    
    
    /// [MK Foundation]
    /// Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
    /// - Parameter type: UITableViewCell.Type
    /// - Parameter identifier: String?
    
    func registerCell(type: UITableViewCell.Type, fromNib: Bool = false) {
        if fromNib {
            register(UINib(nibName: type.identifier, bundle: nil), forCellReuseIdentifier: type.identifier)
        }
        else {
            self.register(type, forCellReuseIdentifier: type.identifier)
        }
    }
    
    func registerCell(type: UITableViewHeaderFooterView.Type, fromNib: Bool = false) {
        if fromNib {
            register(UINib(nibName: type.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: type.identifier)
        }
        else {
            self.register(type, forHeaderFooterViewReuseIdentifier: type.identifier)
        }
    }
    
    
    /// [MK Foundation]
    /// DequeueCell by passing the type of UITableViewCell
    /// - Parameter type: UITableViewCell.Type
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueCell<T: UITableViewHeaderFooterView>(withType type: UITableViewHeaderFooterView.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as? T
    }
    
    
    /// [MK Foundation]
    /// DequeueCell by passing the type of UITableViewCell and IndexPath
    /// - Parameter type: UITableViewCell.Type
    /// - Parameter indexPath: IndexPath
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    /// [MK Foundation]
    /// - Parameter section: section to get last row in.
    /// - Returns: optional last indexPath for last row in section (if applicable).
    func indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0  else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
    
    /// Index path of last row in tableView.
    var indexPathForLastRow: IndexPath? {
        guard let lastSection = lastSection else { return nil }
        return indexPathForLastRow(inSection: lastSection)
    }
    
    /// SwifterSwift: Index of last section in tableView.
    var lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1 : nil
    }
}

public extension UITableView {
    func removeEventDelay() {
        self.delaysContentTouches = false
        for case let subview as UIScrollView in self.subviews {
            subview.delaysContentTouches = false
        }
    }
}

public extension UITableView {
    func updateRowHeightsWithoutReloadingRows(animated: Bool = false) {
        let block = {
            self.beginUpdates()
            self.endUpdates()
        }
        
        if animated {
            block()
        }
        else {
            UIView.performWithoutAnimation {
                block()
            }
        }
    }
}

public extension UITableView {
    func isLastIndexPath(indexPath: IndexPath) -> Bool {
        let totalRows = self.numberOfRows(inSection: indexPath.section)
        // first get total rows in that section by current indexPath.
        if indexPath.row == totalRows - 1 {
            return true
        }
        else {
            return false
        }
    }
}
