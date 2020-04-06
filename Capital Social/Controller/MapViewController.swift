//
//  MapViewController.swift
//  Capital Social
//
//  Created by Jose Vargas on 06/04/20.
//  Copyright © 2020 joscompany. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        addAnnotation()
    }
    
    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Show alert letting the user know they have to turn this on.
        self.showAlert(title: "Hola", message: "No olvides activar tus servicios de ubicacion", style: .default)
      }
    }
    
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedWhenInUse:
        mapView.showsUserLocation = true
       case .denied: // Show alert telling users how to turn on permissions
       break
      case .notDetermined:
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
      case .restricted: // Show an alert letting them know what’s up
       break
      case .authorizedAlways:
       break
      @unknown default:
        fatalError()
        }
    }
    
    func addAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.title = "Punto!"
        annotation.coordinate = CLLocationCoordinate2D(latitude:
          19.4141, longitude: -99.1799)
        mapView.addAnnotation(annotation)
    }
}
