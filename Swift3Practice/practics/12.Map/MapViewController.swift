//
//  MapViewController.swift
//  Swift3Practice
//
//  Created by YaoYaoX on 17/2/8.
//  Copyright © 2017年 YY. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var mapview: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        addAnnotation()
    }
    
    func setupSubviews(){
        view.backgroundColor = UIColor.white
        let mapview = MKMapView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        mapview.delegate = self;
        view.addSubview(mapview)
        self.mapview = mapview;
    }
    
    func addAnnotation(){
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", subtitle: "ld")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", subtitle:"ol")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", subtitle:"pr")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", subtitle:"rm")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", subtitle:"wst")
        mapview.addAnnotations([london, oslo, paris, rome, washington])
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "capital"
        
        if annotation is Capital {
            var annotationview = mapview.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationview == nil {
                annotationview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationview?.canShowCallout = true
                
                let button = UIButton(type: .detailDisclosure)
                annotationview?.rightCalloutAccessoryView = button;
                
            } else {
                annotationview?.annotation = annotation
            }
            return annotationview
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        mapview.deselectAnnotation(view.annotation, animated: true)
        let ac = UIAlertController(title: "info", message: (view.annotation as! Capital).info, preferredStyle: .alert)
        let action = UIAlertAction(title: "confirm", style: .default, handler: nil)
        ac.addAction(action)
        present(ac, animated: true, completion: nil);
    }
    
}
