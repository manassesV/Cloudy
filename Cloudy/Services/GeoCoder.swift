//
//  GeoCoder.swift
//  Cloudy
//
//  Created by Usuário Convidado on 28/09/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import Foundation
import CoreLocation

class Geocoder: LocationService{
    
    func geocode(addressString: String?, completionHandler: @escaping ([Location], Error?) -> Void) {
        guard let addressString = addressString else {
            completionHandler([], nil)
            return
        }
        
        geocoder.geocodeAddressString(addressString) {(placemarks, error) in
            if let error = error {
                completionHandler([], error)
                return
            }
            if let placemarks = placemarks{
                let locations = placemarks.compactMap({ (CLPlacemark) -> Location? in
                    guard let name = CLPlacemark.name else {return nil}
                    guard let location = CLPlacemark.location else {return nil}
                    
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
                completionHandler(locations, nil)
            }

        }
    }
    
    
    private lazy var geocoder = CLGeocoder()
    
    
   
    
    
}



protocol LocationService {
    func geocode(addressString: String?, completionHandler: @escaping ([Location], Error?) -> Void)
    
}
