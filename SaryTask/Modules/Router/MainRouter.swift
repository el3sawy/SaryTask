//
//  MainRouter.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

protocol MainRouterProtocol: Router {
    func pushCatalogDetails(with image: String?)
}

enum MainRouter: RouterProtocol {
    
    // MARK: - Cases
    case home
    case catalogDetails(image: String?)
    
    // MARK: - Properties
    var navigationStyle: NavigationStyle {
        switch self {
        case .catalogDetails, .home:
            return .present(animated: true)
        }
    }
    
    var destinationViewController: UIViewController {
        switch self {
            
        case .home:
            return MainConfigurator.getViewController(with: .home)
        case .catalogDetails(image: let image):
            return MainConfigurator.getViewController(with: .catalogDetails(image: image))
        }
    }
}
