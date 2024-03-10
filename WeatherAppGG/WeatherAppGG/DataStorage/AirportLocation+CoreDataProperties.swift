//
//  AirportLocation+CoreDataProperties.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 10/03/2024.
//
//

import Foundation
import CoreData


extension AirportLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AirportLocation> {
        return NSFetchRequest<AirportLocation>(entityName: "AirportLocation")
    }

    @NSManaged public var airportCode: String
    @NSManaged public var lastFetchDate: String
    @NSManaged public var forecastReport: ForecastWeatherReport?
    @NSManaged public var currentReport: CurrentWeatherReport?

}

extension AirportLocation : Identifiable {

}
