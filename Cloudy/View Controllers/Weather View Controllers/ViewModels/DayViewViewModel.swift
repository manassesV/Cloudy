//
//  DayViewViewModel.swift
//  Cloudy
//
//  Created by Usuário Convidado on 28/09/19.
//  Copyright © 2019 Cocoacasts. All rights reserved.
//

import Foundation
import UIKit



struct DayViewViewModel {
    
    let weatherData: WeatherData
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter
    }()
    
    
    private let timeFormatter = DateFormatter()
    
    
    var date: String{
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String{
        timeFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
        return timeFormatter.string(from: weatherData.time)
    }
    
    
    var summary: String{
        return weatherData.summary
    }
    
    var temperature:  String{
        let temperature = weatherData.temperature
        
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.1f ºF", temperature)
        case .celsius:
            return String(format: "%.1f ºF", temperature.toCelcius())
        }
    }

    
    
}
