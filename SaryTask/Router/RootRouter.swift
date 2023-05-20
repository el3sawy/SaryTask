//
//  RootRouter.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

enum RootRouter: RouterProtocol {
    
    // MARK: - Cases
    case root
    
    // MARK: - Properties
    var navigationStyle: NavigationStyle {
        switch self {
        case .root:
            return .present(animated: true)
        }
    }
    
    var destinationViewController: UIViewController {
        switch self {
        case .root:
            return MainConfigurator.getViewController(with: .home)
        }
    }
}
