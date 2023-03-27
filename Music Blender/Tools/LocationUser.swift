//
//  LocationUser.swift
//  Music Blender
//
//  Created by Tran Long on 18/02/2023.
//

import Foundation
import CoreLocation
import UIKit
import WebKit

class MyLocationManager: NSObject, CLLocationManagerDelegate {
    
    var cityname: String?
    let locationManager = CLLocationManager()
    var completionHandler: ((String?) -> Void)?
    
    func getCurrentCity(completion: @escaping(String?) -> Void){
        
        completionHandler = completion
        
        // Wait for authorization staus change before requesting location update
        locationManager.delegate = self
        
        // Check that if the location service are authorieze
        switch locationManager.authorizationStatus {
        case .denied, .restricted:
            print("Location service are not authorized")
            completion(nil)
            return
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        default: break
        }
        
        // REquest location update
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingHeading()
        
        guard let currentLocation = locationManager.location else {
            completion(nil)
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation) { [self] (placemarks, error) in
            
            guard error == nil else {
                print("Error getting user location \(error!)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("Error getting placemark")
                completion(nil)
                return
            }
            
            let city = placemark.locality ?? ""
            self.cityname = city
            completion(city)

        }
        
    }
}









