//
//  ViewController.swift
//  Maps
//
//  Created by Daniel Marques Da Silva on 11/15/15.
//  Copyright © 2015 Daniel Marques Da Silva. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location user
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        
        // Updating maps (Location user)
        locationManager.startUpdatingLocation()
        
        
        let latitude:CLLocationDegrees  = -23.545384
        let longitude: CLLocationDegrees = -46.724274
        
        let latDelta = 0.01
        let longDelta = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta,longDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        let pressureManager = UILongPressGestureRecognizer(target: self, action: "action:")
        pressureManager.minimumPressDuration = 2
        
        map.addGestureRecognizer(pressureManager)
        map.showsUserLocation = true
    }
    
    func action(gestureRecognizer: UIGestureRecognizer){
        
        let touchPoint = gestureRecognizer.locationInView(self.map)
        
        let newCoordinate:CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let annotation = MKPointAnnotation();
        annotation.coordinate = newCoordinate
        
        annotation.title = "Lugar Legal"
        annotation.subtitle = "Não Deixar de ir"
        
        self.map.addAnnotation(annotation)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta = 0.01
        let longDelta = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta,longDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

