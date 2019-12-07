//
//  AppDisplayable.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import UIKit

protocol AppDisplayable {
    func display(title: String,
                 error: String,
                 actions: [UIAlertAction])
}

extension AppDisplayable where Self: UIViewController {
    
    func display(title: String,
                 error: String,
                 actions: [UIAlertAction]) {
        let alertController = UIAlertController(
            title: title,
            message: error,
            preferredStyle: .alert
        )
        for action in actions {
            alertController.addAction(action)
        }
        
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootController.present(alertController, animated: true, completion: nil)
    }
}
