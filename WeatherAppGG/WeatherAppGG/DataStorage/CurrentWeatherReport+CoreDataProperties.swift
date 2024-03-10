//
//  CurrentWeatherReport+CoreDataProperties.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 10/03/2024.
//
//

import Foundation
import CoreData


extension CurrentWeatherReport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrentWeatherReport> {
        return NSFetchRequest<CurrentWeatherReport>(entityName: "CurrentWeatherReport")
    }

    @NSManaged public var ident: String?
    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var tempC: Int16
    @NSManaged public var relativeHumidity: Int16
    @NSManaged public var flightRules: String?
    @NSManaged public var pressureHpa: Double
    @NSManaged public var pressureHg: Double
    @NSManaged public var dateIssued: String?
    @NSManaged public var elevationFt: Int64
    @NSManaged public var text: String?

}

extension CurrentWeatherReport : Identifiable {

}
