//
//  PreviewInteractor.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import UIKit

class PreviewInteractor {
    var output: PreviewInteractorPresenterInterface?
}

extension PreviewInteractor: PreviewViewControllerInteractorInterface {
    func previewImage(request: Preview.Info) {
        self.output?.previewImage(response: request)
    }
}
