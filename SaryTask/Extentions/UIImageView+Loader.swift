//
//  UIImageView+Loader.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func load(with url: String?) {
        let placeholderImage = UIImage(named: "dummy")
        guard let imageURLString = url,
                let fullURLString = URL(string: imageURLString) else {
            self.image = placeholderImage
            return
        }
        af.setImage(withURL: fullURLString, placeholderImage: placeholderImage)
    }
}
