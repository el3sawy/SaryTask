//
//  MainConfigurator.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

enum MainConfiguratorType {
    case home
    case catalogDetails(image: String?)
}

enum MainConfigurator {
    static func getViewController(with type: MainConfiguratorType) -> UIViewController {
        switch type {
            
        case .home:
            return configHomeViewController()
        case .catalogDetails(image: let image):
            return catalogDetailsViewController(image: image)
        }
    }
    
    private static func configHomeViewController() -> UIViewController {
        let network = Network.shared
        let repository = MainRepository(network: network)
        let catalogUseCase = CatalogUseCase(repository: repository)
        let sliderUseCase = SliderUseCase(repository: repository)
        let viewModel = HomeViewModel(sliderUseCase: sliderUseCase, catalogUseCase: catalogUseCase)
        let homeViewController = HomeViewController(viewModel: viewModel)
        return homeViewController
    }
    
    private static func catalogDetailsViewController(image: String?) -> UIViewController {
        CatalogDetailsViewController(image: image)
    }
}
