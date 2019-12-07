//
//  CameraMapViewDelegate.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import MapKit

protocol CameraMapViewProtocol: class {
    func annotationDidSelect(annotation: CameraPointAnnotation,
                             sender: UIView)
}

class CameraMapViewDelegate: NSObject, MKMapViewDelegate {
    
    weak var delegate: CameraMapViewProtocol?
    
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }

        var annotationView: MKAnnotationView?

        if let annotation = annotation as? CameraPointAnnotation {
            let identifier  = "CameraMapIdentifier"
            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier:
                identifier) {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            } else {
                
                annotationView = MKMarkerAnnotationView(annotation: annotation,
                                                  reuseIdentifier: identifier)
            }

            if let annotationView = annotationView {
                annotationView.canShowCallout = true
            }
        }
        annotationView?.accessibilityIdentifier = "MapAnnotaAccesIdentifier"
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annot = view.annotation as? CameraPointAnnotation {
            delegate?.annotationDidSelect(annotation: annot, sender: view)
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                mapView.deselectAnnotation(annot, animated: true)
            }
        }
    }
}
