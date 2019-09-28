//
//  AddLocationViewModel.swift
//  Cloudy
//
//  Created by Usuário Convidado on 28/09/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import Foundation
import CoreLocation


class AddLocationViewModel {
    
    private var locationService: LocationService
    
    
    init(locationService: LocationService) {
       self.locationService = locationService
    }
    
    private var querying: Bool = false {
        didSet{
            queryingDidChange?(querying)
        }
    }
    
    
    private var locations:[Location] = [] {
        didSet{
            locationDidChange?(locations)
        }
    }
    
    //Closure
    var queryingDidChange:((Bool)->())?
    var locationDidChange: (([Location]) -> ())?
    var query: String = ""{
        didSet{
            geocode(addressString: query)
        }
    }
    
    
    
    var hasLocation: Bool {
        return !locations.isEmpty
    }
    var numberOfLocations: Int {
        return locations.count
    }
    
    func viewModelForLocation(at index: Int) -> LocationRepresentable? {
        guard let location = location(at: index) else {return nil}
        
        return LocationsViewLocationViewModel(location: location.location, locationAsString: location.name)
        
    }
    
    func location(at index: Int) -> Location? {
        if index >= locations.count {return nil}
        return locations[index] 
    }
    
    
    private func geocode(addressString: String?){
        guard let addressString = addressString, !addressString.isEmpty else{
            locations = []
            return
        }
        
        querying = true
        
        
        locationService.geocode(addressString: addressString){(locations, error) in
            if let error = error {
                print(error)
            }else{
                self.locations = locations
            }
        }
        querying = false
    }
}
