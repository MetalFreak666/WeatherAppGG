//
//  LocationDetailViewModel.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 08/03/2024.
//

import Foundation

class LocationDetailViewModel {
    
    // MARK: - Properties
    var weatherReport: WeatherReport?
    
    init(weatherReport: WeatherReport? = nil) {
        self.weatherReport = weatherReport
    }
    
}

