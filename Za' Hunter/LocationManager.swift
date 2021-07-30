//
//  LocationManager.swift
//  Za' Hunter
//
//  Created by Aneesh Pushparaj on 7/30/21.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager = CLLocationManager()
    override init() { // Initializer for the Location Manager class
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Pop-up for Location Authorization and receives that information
        locationManager.startUpdatingLocation() // Updates Location when authorized
    }
}
