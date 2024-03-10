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
    
    // MARK: - Core data
    func fetchLastAirportLocationsFromStorage(context: NSManagedObjectContext, completion: @escaping(Error?) -> Void) {
        let initAirportLocations: [String] = ["KAUS", "KPWM"]
        do {
            self.storiedAirportLocations = try context.fetch(AirportLocation.fetchRequest())
            
            if self.storiedAirportLocations.isEmpty {
                for airportId in initAirportLocations {
                    self.getLocationForecast(airportId: airportId) { weatherReport, error in
                        if let error {
                            completion(error)
                        } else {
                            guard let report = weatherReport else { return }
                            
                            self.addAirportWeatherReportToStorage(context: context,
                                                                  airportId: airportId,
                                                                  weatherReport: report) { error in
                                if let error {
                                    completion(error)
                                } else {
                                    completion(nil)
                                }
                            }
                            completion(nil)
                        }
                    }
                }
            }
        } catch {
            print("Could not fetch storied locations...")
            completion(nil)
        }
        completion(nil)
    }
    
    func addAirportWeatherReportToStorage(context: NSManagedObjectContext, airportId: String, weatherReport: WeatherReport, completion: @escaping(Error?) -> Void) {
        let newSearchLocation = AirportLocation(context: context)
        newSearchLocation.airportCode = airportId
        newSearchLocation.lastFetchDate = getTimestampt()
        
        let currentReport = CurrentWeatherReport(context: context)
        currentReport.dateIssued = weatherReport.report.conditions.dateIssued
        currentReport.elevationFt = Int64(weatherReport.report.conditions.elevationFt)
        currentReport.flightRules = weatherReport.report.conditions.flightRules
        currentReport.ident = weatherReport.report.conditions.ident
        currentReport.lat = weatherReport.report.conditions.lat
        currentReport.lon = weatherReport.report.conditions.lon
        currentReport.pressureHg = weatherReport.report.conditions.pressureHg
        currentReport.pressureHpa = weatherReport.report.conditions.pressureHpa
        currentReport.relativeHumidity = Int16(weatherReport.report.conditions.relativeHumidity)
        currentReport.tempC = Int16(weatherReport.report.conditions.tempC)
        currentReport.text = weatherReport.report.conditions.text
        
        let forecastReport = ForecastWeatherReport(context: context)
        forecastReport.ident = weatherReport.report.forecast.ident
        forecastReport.dateIssued = weatherReport.report.forecast.dateIssued
        forecastReport.lat = weatherReport.report.forecast.lat
        forecastReport.lon = weatherReport.report.forecast.lon
        
        newSearchLocation.forecastReport = forecastReport
        newSearchLocation.currentReport = currentReport
        
        do {
            try context.save()
        } catch {
            completion(error)
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
