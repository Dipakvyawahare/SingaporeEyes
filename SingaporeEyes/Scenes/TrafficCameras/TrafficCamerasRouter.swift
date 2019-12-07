//
//  TrafficCamerasRouter.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import UIKit

protocol TrafficCamerasRouterInput {
    func showPreview(cam: ViewModelCamera)
}

class TrafficCamerasRouter: TrafficCamerasRouterInput {
    weak var viewController: TrafficCamerasViewController?
    
    func showPreview(cam: ViewModelCamera) {
        let pvc = viewController?.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController")
        if let previewVC = pvc as? PreviewViewController {
            previewVC.providesPresentationContextTransitionStyle = true
            previewVC.definesPresentationContext = true
            previewVC.modalPresentationStyle = .overCurrentContext
            previewVC.modalTransitionStyle = .crossDissolve
            viewController?.present(previewVC, animated: true, completion: {
                let info = Preview.Info.init(imageUrl: cam.image, timestamp: cam.timestamp)
                previewVC.output?.previewImage(request: info)
            })
        }
    }
}
