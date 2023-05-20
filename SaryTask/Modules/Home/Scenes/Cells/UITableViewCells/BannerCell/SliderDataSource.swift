//
//  SliderDataSource.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import UIKit
import RxSwift

final class SliderDataSource: NSObject {
    
    // MARK: - Properties
    private let images: [String?]
    var currentPageSubject = PublishSubject<Int>()
    var didTappedSlider = PublishSubject<String?>()
    
    // MARK: - init
    init(images: [String?]) {
        self.images = images
    }
}

// MARK: - UICollectionViewDataSource
extension SliderDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageUICollCollectionViewCell = collectionView.dequeue(at: indexPath)
        cell.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
}

// MARK: - UICollectionViewDelegate
extension SliderDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTappedSlider.onNext(images[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        let currentPage = Int(offSet + horizontalCenter) / Int(width)
        currentPageSubject.onNext(currentPage)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SliderDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width  , height: collectionView.frame.height)
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }
}
