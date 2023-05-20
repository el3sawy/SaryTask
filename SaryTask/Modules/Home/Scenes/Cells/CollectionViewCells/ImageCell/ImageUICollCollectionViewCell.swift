//
//  ImageUICollCollectionViewCell.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit

final class ImageUICollCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var bannerImage: UIImageView!
    
    // MARK: -  Properties
    var image: String? {
        didSet {
            bannerImage.load(with: image)
            bannerImage.layer.cornerRadius = 8
        }
    }
}
