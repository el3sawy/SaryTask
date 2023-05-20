//
//  NavigationStyle.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

enum NavigationStyle {
    case present(animated: Bool)
}

protocol RouterProtocol {
    var navigationStyle: NavigationStyle { get }
    var destinationViewController: UIViewController { get }
}
