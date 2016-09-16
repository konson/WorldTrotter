//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alecsandra Konson on 9/8/16.
//  Copyright © 2016 Apperator. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Add find me button
        let findMeButton = UIButton()
        findMeButton.frame = CGRect(x: 140 , y: 550, width: 100, height: 50)
        findMeButton.setTitle("Find Me", for: .normal)
        findMeButton.setTitleColor(UIColor.blue, for: .normal)
        findMeButton.addTarget(self, action: #selector(MapViewController.findMeButtonPressed), for: UIControlEvents.touchUpInside)
        self.view.addSubview(findMeButton)


    }

    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as THE view of this view controller
        view = mapView
        
        // Set up segment control for 3 views

        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        // Add the controls to the view
        view.addSubview(segmentedControl)
        
        // Set constraints for controls
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        // Activate constraints
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true

    }
    
    
    //# MARK: - Segmented control
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    //# MARK: - Find Me location
    
    func findMeButtonPressed(){

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        print(location?.coordinate.latitude)
        print(location?.coordinate.longitude)
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        mapView.setRegion(region, animated: true)
        //mapView.setCenter(center, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: " + error.localizedDescription)
    }
    

}
