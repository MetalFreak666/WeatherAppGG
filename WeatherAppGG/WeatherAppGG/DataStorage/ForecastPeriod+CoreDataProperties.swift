//
//  ForecastPeriod+CoreDataProperties.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 10/03/2024.
//
//

import Foundation
import CoreData


extension ForecastPeriod {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastPeriod> {
        return NSFetchRequest<ForecastPeriod>(entityName: "ForecastPeriod")
    }

    @NSManaged public var dateEnd: String?
    @NSManaged public var dateStart: String?

}

extension ForecastPeriod : Identifiable {

}
