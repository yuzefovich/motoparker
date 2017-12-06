//
//  UnmeteredMapViewController.swift
//  MotoParker
//
//  Created by Yahor Yuzefovich on 12/5/17.
//  Copyright © 2017 Yahor Yuzefovich. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class UnmeteredMapViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 5000
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        if let location = manager.location {
            centerMapOnLocation(location: location)
        }
        for i in 0...(unmetered.count-1) {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: unmetered[i].latitude, longitude: unmetered[i].longitude)
            annotation.title = "\(unmetered[i].spaces) spaces"
            mapView.addAnnotation(annotation)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { print("not enabled"); return }
        mapView.showsUserLocation = true
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


