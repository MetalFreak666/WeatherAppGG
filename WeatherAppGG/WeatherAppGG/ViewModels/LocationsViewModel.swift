//
//  LocationsViewModel.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation
import CoreData

class LocationsViewModel {
    
    // MARK: - Properties
    typealias ForecastCompletion = (WeatherReport?, Error?) -> Void
    
    private let httpClient = AlamofireWeatherForecastHTTPClient()
    var storiedAirportLocations: [AirportLocation] = []
    
    init() {}
   
    // MARK: - Actions
    func getLocationForecast(airportId: String, completion: @escaping ForecastCompletion) {
        httpClient.getWeatherForecast(aiportId: airportId) { report, error in
            if let error {
                completion(nil, error)
            } else {
                if let forecastReport = report {
                    completion(forecastReport, nil)
                } else {
                    completion(nil, nil)
                }
            }
        }
    }
}

//MARK: - DateFormatter
extension LocationsViewModel {
    func getTimestampt() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
}
