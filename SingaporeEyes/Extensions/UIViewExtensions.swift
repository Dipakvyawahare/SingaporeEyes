//
//  UIViewExtensions.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import UIKit

extension UIView {
    func pinToSuperView() {
        guard let superview = self.superview else {
            assert(false, "Error! `superview` was nil")
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }
}
