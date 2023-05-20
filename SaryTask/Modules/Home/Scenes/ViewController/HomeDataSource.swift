//
//  HomeDataSource.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 19/05/2023.
//

import UIKit
import RxSwift

final class HomeDataSource: NSObject {
    
    // MARK: - Properties
    private let categories: [any BaseHomeModelProtocol]
    private let sliderRowHeight: CGFloat = 225
    private let headerHeight: CGFloat = 30
    let disposeBag = DisposeBag()
    var didTappedSlider = PublishSubject<String?>()
    var didTappedCatalog = PublishSubject<ProductUIModel>()
    
    // MARK: - init
    init(categories: [any BaseHomeModelProtocol]) {
        self.categories = categories
    }
}

// MARK: - UITableViewDataSource
extension HomeDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        categories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = categories[indexPath.section]
        
        switch item.homeSection {
        case .slider:
            let cell: BannerTableViewCell = tableView.dequeue()
            cell.items = (item as! SliderUIModel).images
            
            cell.didTappedSlider
                .subscribe(didTappedSlider)
                .disposed(by: disposeBag)
            
            return cell
        case .catalog:
            let cell: ListProductsTableViewCell = tableView.dequeue()
            cell.item = (item as! CatalogUIModel)
            
            cell.didTappedProduct
                .subscribe(didTappedCatalog)
                .disposed(by: disposeBag)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = categories[indexPath.section]
        switch item.homeSection {
            
        case .slider:
            return sliderRowHeight
        case .catalog:
            let item = (item as! CatalogUIModel)
            return CGFloat(item.rowHeight)
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = categories[section]
        guard item.homeSection == .catalog else {
            return nil
        }
        let catalog = item as! CatalogUIModel
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let titleLabel = UILabel()
        titleLabel.text = catalog.title
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .right
        
        headerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            titleLabel.centerY(anchor: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = categories[section]
        switch item.homeSection {
            
        case .slider:
            return 0
        case .catalog:
            return headerHeight
        }
    }
}
