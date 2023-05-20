//
//  ListProductsTableViewCell.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit
import RxSwift

final class ListProductsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var dataSource = CatalogDataSource(catalog: CatalogUIModel(products: []))
    private let disposeBag = DisposeBag()
    
    var didTappedProduct: Observable<ProductUIModel> {
        dataSource.didTappedProduct.asObservable()
    }
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    // MARK: - Functions
    private func setupCollectionView() {
        collectionView.register(nib: ProductCollectionViewCell.self)
        
    }
    
    var item: CatalogUIModel! {
        didSet {
            dataSource = CatalogDataSource(catalog: item)
            collectionView.dataSource = dataSource
            collectionView.delegate = dataSource
            setupFlowLayout(direction: item.collectionViewType)
            collectionView.reloadData()
        }
    }
    
    private func setupFlowLayout(direction: CatalogTypeEnum) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction  == .grid ? .vertical : .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = direction == .linear
    }
}

