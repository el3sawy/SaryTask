//
//  NavigationRoute.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

protocol NavigationRoute {
    func present(to router: RouterProtocol)
}

extension NavigationRoute where Self: UIViewController {
    func present(to router: RouterProtocol) {
        switch router.navigationStyle {
        case .present(let animated):
            navigationController?.present(router.destinationViewController, animated: animated)
        }
    }
}
