//
//  ForecastWeatherReport+CoreDataProperties.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 09/03/2024.
//
//

import Foundation
import CoreData


extension ForecastWeatherReport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastWeatherReport> {
        return NSFetchRequest<ForecastWeatherReport>(entityName: "ForecastWeatherReport")
    }

    @NSManaged public var text: String?
    @NSManaged public var ident: String?
    @NSManaged public var lat: Double
    @NSManaged public var elevationFt: Int64
    @NSManaged public var dateIssued: String?
    @NSManaged public var lon: Double

}

extension ForecastWeatherReport : Identifiable {

}
