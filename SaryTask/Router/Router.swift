//
//  Router.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

protocol Router {
    var sourceViewController: UIViewController? {get set}
    func pushViewController(_ viewController: UIViewController)
}

extension Router {
    func pushViewController(_ viewController: UIViewController) {
        sourceViewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
