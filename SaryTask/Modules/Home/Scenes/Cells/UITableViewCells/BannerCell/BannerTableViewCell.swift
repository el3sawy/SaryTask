//
//  BannerTableViewCell.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit
import RxSwift

final class BannerTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var pageController: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var dataSource: SliderDataSource = SliderDataSource(images: [])
    private let disposeBag = DisposeBag()
    
    var didTappedSlider: Observable<String?> {
        dataSource.didTappedSlider.asObservable()
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        
    }
    
    // MARK: - Functions
    private func setupCollectionView() {
        collectionView.register(nib: ImageUICollCollectionViewCell.self)
    }
    
    var items: [String?] = [] {
        didSet {
            dataSource = SliderDataSource(images: items)
            bindPageController()
           
            collectionView.dataSource = dataSource
            collectionView.delegate = dataSource
            
            collectionView.reloadData()
            pageController.numberOfPages = items.count
        }
    }
    
    private func bindPageController() {
        dataSource.currentPageSubject.subscribe { [weak self] page in
            self?.pageController.currentPage = page
        }
        .disposed(by: disposeBag)
    }
}
