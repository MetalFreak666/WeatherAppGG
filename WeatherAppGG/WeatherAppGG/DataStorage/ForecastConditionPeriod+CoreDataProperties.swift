//
//  ForecastConditionPeriod+CoreDataProperties.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 10/03/2024.
//
//

import Foundation
import CoreData


extension ForecastConditionPeriod {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastConditionPeriod> {
        return NSFetchRequest<ForecastConditionPeriod>(entityName: "ForecastConditionPeriod")
    }

    @NSManaged public var dateEnd: String?
    @NSManaged public var dateStart: String?

}

extension ForecastConditionPeriod : Identifiable {

}
