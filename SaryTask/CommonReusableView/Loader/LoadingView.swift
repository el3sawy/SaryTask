//
//  LoadingView.swift
//  SaryTask
//
//  Created by Ahmed Naguib on 20/05/2023.
//

import UIKit

final class LoadingView: UIView {
    
    static let shared = LoadingView()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = .systemBlue
        activityIndicator.color = .systemGray
        return activityIndicator
    }()
    
    private init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        addSubview(activityIndicator)
        backgroundColor = .lightGray.withAlphaComponent(0.5)
        layer.cornerRadius = 10
        
        activityIndicator.centerX(anchor: centerXAnchor)
        activityIndicator.centerY(anchor: centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
