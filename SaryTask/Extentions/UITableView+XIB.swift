//
//  UITableView+.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit

extension UITableView {
    
    @discardableResult
    func register<T: UITableViewCell>(nib cell: T.Type) -> Self {
        register(cell.nib, forCellReuseIdentifier: cell.id)
        return self
    }
    
    func dequeue<T: UITableViewCell>() -> T {
        let id = T.id
        guard let cell = dequeueReusableCell(withIdentifier: id) as? T
        else { fatalError("Cannot dequeue cell with identifier '\(id)'") }
        return cell
    }
}
