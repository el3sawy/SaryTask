//
//  UICollectionView+.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit

extension UICollectionView {
    
    @discardableResult
    func register<T: UICollectionViewCell>(nib cell: T.Type) -> Self {
        register(cell.nib, forCellWithReuseIdentifier: cell.id)
        return self
    }
    
    func dequeue<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        let id = T.id
        guard let cell = dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? T
        else { fatalError("Cannot dequeue cell with identifier '\(id)'") }
        return cell
    }
}

extension UIView {
    static var id: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: "\(self)",bundle : nil) }
}
