//
//  PreviewInterfaces.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

protocol PreviewViewControllerInteractorInterface {
    func previewImage(request: Preview.Info)
}

protocol PreviewInteractorPresenterInterface {
    func previewImage(response: Preview.Info)
}

protocol PreviewPresenterViewControllerInterface: class {
    func previewImage(viewModel: Preview.ViewModel)
}
