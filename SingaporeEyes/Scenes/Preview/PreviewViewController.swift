//
//  PreviewViewController.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import UIKit
import Kingfisher

class PreviewViewController: UIViewController {
    var output: PreviewViewControllerInteractorInterface?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    private func setupVIPCycle() {
        let presenter = PreviewPresenter()
        presenter.output = self
        let interactor = PreviewInteractor()
        interactor.output = presenter
        self.output = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        if let gifData = getGifData() {
            imageView.kf.indicatorType = .image(imageData: gifData)
        } else {
            imageView.kf.indicatorType = .activity
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapToClose() {
        dismiss(animated: true, completion: nil)
    }
}

extension PreviewViewController: PreviewPresenterViewControllerInterface {
    func previewImage(viewModel: Preview.ViewModel) {
        timeLabel.text = viewModel.timestamp
        let processor =  RoundCornerImageProcessor(cornerRadius: 15)
        imageView.kf.setImage(with: viewModel.imageUrl,
                              options: [
                                .processor(processor),
                                .transition(.fade(1)),
                                .cacheOriginalImage
            ])
    }
    
    func getGifData() -> Data? {
        var gifData: Data?
        do {
            let url = Bundle.main.url(forResource: "loader", withExtension: "gif")!
            gifData = try Data(contentsOf: url)
        } catch {}
        return gifData
    }
}
