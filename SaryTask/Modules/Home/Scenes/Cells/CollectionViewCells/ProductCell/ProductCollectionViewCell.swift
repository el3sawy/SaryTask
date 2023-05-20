//
//  ProductCollectionViewCell.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var productImage: UIImageView!

    // MARK: -  Properties
    var item: ProductUIModel! {
        didSet {
            productImage.load(with: item.image)
        }
    }
}
