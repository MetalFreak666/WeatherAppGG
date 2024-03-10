//
//  ForecastCondition+CoreDataProperties.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 10/03/2024.
//
//

import Foundation
import CoreData


extension ForecastCondition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastCondition> {
        return NSFetchRequest<ForecastCondition>(entityName: "ForecastCondition")
    }

    @NSManaged public var flightRules: String?
    @NSManaged public var dateIssued: String?
    @NSManaged public var relativeHumidity: Int64
    @NSManaged public var lon: Double
    @NSManaged public var text: String?
    @NSManaged public var elevationFt: Int64
    @NSManaged public var lat: Double
    @NSManaged public var conditions: NSSet?
    @NSManaged public var period: ForecastConditionPeriod?

}

// MARK: Generated accessors for conditions
extension ForecastCondition {

    @objc(addConditionsObject:)
    @NSManaged public func addToConditions(_ value: ForecastWeatherReport)

    @objc(removeConditionsObject:)
    @NSManaged public func removeFromConditions(_ value: ForecastWeatherReport)

    @objc(addConditions:)
    @NSManaged public func addToConditions(_ values: NSSet)

    @objc(removeConditions:)
    @NSManaged public func removeFromConditions(_ values: NSSet)

}

extension ForecastCondition : Identifiable {

}
