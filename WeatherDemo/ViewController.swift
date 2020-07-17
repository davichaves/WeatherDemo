//
//  ViewController.swift
//  WeatherDemo
//
//  Created by Davi Chaves on 7/17/20.
//  Copyright © 2020 Davi Chaves. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    var firstTap = false
    var tappedLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        let tapInterceptor = WildCardGestureRecognizer(target: nil, action: nil)
        tapInterceptor.touchesBeganCallback = {
            _, _ in
            self.handleTap()
        }
        map.addGestureRecognizer(tapInterceptor)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap))
        gestureRecognizer.delegate = self
        map.addGestureRecognizer(gestureRecognizer)
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            map.showsUserLocation = true
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            map.showsUserLocation = true
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func handleTap() {
        var timer: Timer?
        if firstTap {
            timer?.invalidate()
            print("double tapped")
            self.firstTap = false
        } else {
            self.firstTap = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.firstTap = false
            }
        }
    }
    
    @objc func handleMapTap(gestureRecognizer: UILongPressGestureRecognizer) {

        let location = gestureRecognizer.location(in: map)
        let coordinate = map.convert(location, toCoordinateFrom: map)
        
        tappedLocation = coordinate
        print("hello from \(coordinate.latitude), \(coordinate.longitude)")
    }
}

