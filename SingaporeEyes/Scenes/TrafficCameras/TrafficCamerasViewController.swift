//
//  TrafficCamerasViewController.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import UIKit

class TrafficCamerasViewController: UIViewController {
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var loaderImageView: UIImageView!
    
    var output: TrafficCamerasViewControllerInteractorInterface?
    var router: TrafficCamerasRouter = TrafficCamerasRouter()
    lazy var mapViewDataSource = TrafficCameraMapViewDataSource()
    lazy var mapViewConfigurator = CameraMapViewDelegate()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }
    
    private func setupVIPCycle() {
        let presenter = TrafficCamerasPresenter()
        presenter.output = self
        presenter.mapViewDataSource = mapViewDataSource
        let interactor = TrafficCamerasInteractor()
        interactor.output = presenter
        self.output = interactor
        router.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.dataSource = mapViewDataSource
        mapView.delegate = mapViewConfigurator
        mapViewConfigurator.delegate = self
        mapViewDataSource.data.addAndNotify(observer: self) { [weak self ] in
            self?.loaderImageView.isHidden = true
            self?.mapView.reloadAnnotations()
            self?.mapView.fitMapViewToAnnotaionList()
        }
        refreshData()
        loaderImageView.image = UIImage(named: "Loading")
        loaderImageView.isHidden = false
        
        //As per API documentation:
        //We recommend that this endpoint be called every minute
        let delay = 59.0
        Timer.scheduledTimer(timeInterval: delay,
                             target: self,
                             selector: #selector(refreshData),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func refreshData() {
        let request = TrafficCameras.Request.init(date: Date())
        output?.fetchCameras(request: request)
    }
}

extension TrafficCamerasViewController: TrafficCamerasPresenterViewControllerInterface, AppDisplayable {
    func displayError(error: ErrorResult) {
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.refreshData()
        }
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        switch error {
        case .custom(let msg):
            self.display(title: "Alert", error: msg, actions: [retryAction])
        case .network(let msg):
            self.display(title: "Network", error: msg, actions: [retryAction])
        case .parser(let msg):
            self.display(title: "Parser", error: msg, actions: [okAction])
        }
    }
}

extension TrafficCamerasViewController: CameraMapViewProtocol {
    func annotationDidSelect(annotation: CameraPointAnnotation, sender: UIView) {
        router.showPreview(cam: annotation.camera)
    }
}
