//
//  CatalogDetailsViewController.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

final class CatalogDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var catalogImage: UIImageView!
    
    // MARK: - Properties
    private let image: String?
    
    // MARK: - Init
    init(image: String?) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    // MARK: - Functions
    private func loadImage() {
        catalogImage.load(with: image)
    }
}
