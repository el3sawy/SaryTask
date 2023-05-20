//
//  HomeViewController.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 18/05/2023.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController, LoadingViewCapable, PresentableAlert, NavigationRoute {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(nib: BannerTableViewCell.self)
            tableView.register(nib: ListProductsTableViewCell.self)
        }
    }
    
    // MARK: - Properties
    private var dataSource: HomeDataSource!
    let disposeBag = DisposeBag()
    private let viewModel: HomeViewModel
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bind()
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    private func bind() {
        viewModel.homeSubject.subscribe { [weak self] state in
            guard let self = self, let state = state.element else {
                return
            }
            self.handleState(state)
        }.disposed(by: disposeBag)
    }
    
    private func handleState(_ state: HomeState) {
        switch state {
        case .showLoader:
            showLoader()
        case .hideLoader:
            hideLoader()
        case .error(let message):
            showAlert(with: message ?? "")
        case .success(let data):
            bindViewData(data)
        }
    }
    
    private func bindViewData(_ data:  [any BaseHomeModelProtocol]) {
        dataSource = HomeDataSource(categories: data)
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
        didTapSlider()
        didTapCatalog()
    }
    
    private func didTapSlider() {
        dataSource.didTappedSlider
            .subscribe { [weak self] value in
                let image = value.element ?? ""
                self?.showAlert(with:  image ?? "")
            }
            .disposed(by: disposeBag)
    }
    
    private func didTapCatalog() {
        dataSource.didTappedCatalog
            .subscribe { [weak self] value in
                let image = value.element?.image
                self?.present(to: MainRouter.catalogDetails(image: image))
            }
            .disposed(by: disposeBag)
    }
}
