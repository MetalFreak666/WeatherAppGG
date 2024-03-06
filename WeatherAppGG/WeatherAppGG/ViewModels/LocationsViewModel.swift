//
//  LocationsViewModel.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation

class LocationsViewModel {
    
    // MARK: - Properties
    typealias ForecastCompletion = (WeatherReport?, Error?) -> Void
    
    private let httpClient = AlamofireWeatherForecastHTTPClient()
    
    // MARK: - Actions
    func getLocationForecast(airportId: String, completion: @escaping ForecastCompletion) {
        httpClient.getWeatherForecast(aiportId: airportId) { report, error in
            if let error {
                //TODO: Do something with the failed request
                completion(nil, error)
            } else {
                //TODO: Do something with the forecast report
                guard let report = report else {
                    return
                }
                
                let forecastReport: WeatherReport = report
                print(forecastReport.report.forecast.conditions.count)
                completion(nil, nil)
            }
        }
    }
    
    func getLastLocations() -> [LastSearchLocation] {
        var lastFetchedLocations: [LastSearchLocation] = []
        
        let mockLocation1: LastSearchLocation = .init(iconName: "airplane.departure",
                                                      lastLocationTitle: "KAUS",
                                                      lastLocationDate: "06-03-2024"
        )
        let mockLocation2: LastSearchLocation = .init(iconName: "airplane.departure",
                                                      lastLocationTitle: "KPWM",
                                                      lastLocationDate: "06-03-2024"
        )
        
        lastFetchedLocations.append(mockLocation1)
        lastFetchedLocations.append(mockLocation2)
        
        return lastFetchedLocations

    }
}
