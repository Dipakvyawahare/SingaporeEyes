//
//  PreviewPresenter.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import Foundation

class PreviewPresenter: PreviewInteractorPresenterInterface {
    weak var output: PreviewPresenterViewControllerInterface?
    
    func previewImage(response: Preview.Info) {
        if let url = URL(string: response.imageUrl) {
            let text = "Timestamp: \(response.displayTitle)"
            output?.previewImage(viewModel: Preview.ViewModel.init(imageUrl: url, timestamp: text))
        }
    }
}
