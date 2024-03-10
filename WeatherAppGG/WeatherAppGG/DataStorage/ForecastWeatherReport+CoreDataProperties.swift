//
//  ForecastWeatherReport+CoreDataProperties.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 10/03/2024.
//
//

import Foundation
import CoreData


extension ForecastWeatherReport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastWeatherReport> {
        return NSFetchRequest<ForecastWeatherReport>(entityName: "ForecastWeatherReport")
    }

    @NSManaged public var dateIssued: String?
    @NSManaged public var elevationFt: Int64
    @NSManaged public var ident: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var text: String?
    @NSManaged public var forecastConditions: NSSet?
    @NSManaged public var period: ForecastPeriod?

}

// MARK: Generated accessors for forecastConditions
extension ForecastWeatherReport {

    @objc(addForecastConditionsObject:)
    @NSManaged public func addToForecastConditions(_ value: ForecastCondition)

    @objc(removeForecastConditionsObject:)
    @NSManaged public func removeFromForecastConditions(_ value: ForecastCondition)

    @objc(addForecastConditions:)
    @NSManaged public func addToForecastConditions(_ values: NSSet)

    @objc(removeForecastConditions:)
    @NSManaged public func removeFromForecastConditions(_ values: NSSet)

}

extension ForecastWeatherReport : Identifiable {

}
