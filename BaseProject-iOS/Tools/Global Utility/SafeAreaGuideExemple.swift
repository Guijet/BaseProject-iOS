//
//  SafeAreaGuideExemple.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-01-24.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

class SafeAreaGuideExemple: UIViewController {

    private let greenView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .green
        view.addSubview(greenView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            greenView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            greenView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                greenView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
                guide.bottomAnchor.constraintEqualToSystemSpacingBelow(greenView.bottomAnchor, multiplier: 1.0)
                ])
            
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                greenView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: standardSpacing)
                ])
        }
    }

}
