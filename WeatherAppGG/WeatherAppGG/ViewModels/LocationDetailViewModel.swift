//
//  LocationDetailViewModel.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 08/03/2024.
//

import Foundation

class LocationDetailViewModel {
    
    // MARK: - Properties
    var weatherReport: WeatherReport?
    var storiedForecastReport: ForecastWeatherReport?
    var storiedCurrentWeatherReport: CurrentWeatherReport?
    var forecastConditionsLight: [ConditionLight] = []
    
    // MARK: - Init
    init(weatherReport: WeatherReport? = nil, storiedForecastReport: ForecastWeatherReport? = nil, storiedCurrentWeatherReport: CurrentWeatherReport? = nil) {
        self.weatherReport = weatherReport
        self.storiedForecastReport = storiedForecastReport
        self.storiedCurrentWeatherReport = storiedCurrentWeatherReport
    }
    
    func initForecastConditions() -> [ConditionLight] {
        if let conditions = weatherReport?.report.forecast.conditions {
            var conditionsLight: [ConditionLight] = []
            for condition in conditions {
                let conditionLight: ConditionLight = .init(id: UUID(),
                                                           period: .init(dateEnd: condition.period.dateEnd, dateStart: condition.period.dateStart),
                                                           lon: condition.lon,
                                                           lat: condition.lat,
                                                           relativeHumidity: condition.relativeHumidity
                )
                conditionsLight.append(conditionLight)
            }
            return conditionsLight
        } else {
            return []
        }
    }
}

