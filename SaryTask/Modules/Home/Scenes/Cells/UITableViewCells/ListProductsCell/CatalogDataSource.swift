//
//  CatalogDataSource.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import UIKit
import RxSwift

final class CatalogDataSource: NSObject {
    
    // MARK: - Properties
    private let catalog: CatalogUIModel
    var didTappedProduct = PublishSubject<ProductUIModel>()
    
    // MARK: - init
    init(catalog: CatalogUIModel) {
        self.catalog = catalog
    }
}

// MARK: - UICollectionViewDataSource
extension CatalogDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeue(at: indexPath)
        cell.item = catalog.products[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        catalog.products.count
    }
}

// MARK: - UICollectionViewDelegate
extension CatalogDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = catalog.products[indexPath.row]
        didTappedProduct.onNext(product)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CatalogDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isGrid = catalog.collectionViewType == .grid
        let widthIfLinear = Double(catalog.rowCount) + 0.2
        let numberOfItemsInRow: Double = isGrid ? Double(catalog.rowCount) : widthIfLinear
        let width =  CGFloat((Double(collectionView.bounds.width)) / numberOfItemsInRow)
        let height = CGFloat(catalog.productCellHeight)
        
        return CGSize(width: width - 10 , height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

