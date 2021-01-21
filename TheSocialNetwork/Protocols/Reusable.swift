//
//  Reusable.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

import UIKit

public protocol Reusable {}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

public extension Reusable where Self: UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: self.reuseIdentifier, bundle: Bundle(for: self))
    }
    
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - UITableView

public extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        
        return cell
    }
    
}
