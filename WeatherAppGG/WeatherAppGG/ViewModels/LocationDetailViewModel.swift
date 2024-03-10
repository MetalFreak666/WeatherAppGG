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
    
    // MARK: - Action
    func weatherDetailLabelConfigurations() -> [(symbolName: String, title: String, text: String)] {
        if let storiedCurrentWeatherReport = storiedCurrentWeatherReport {
            return [
                ("thermometer.low", "Temperature :", String(storiedCurrentWeatherReport.tempC)),
                ("tirepressure", "Pressure HG :", String(storiedCurrentWeatherReport.pressureHg)),
                ("tirepressure", "Pressure HPA :", String(storiedCurrentWeatherReport.pressureHpa)),
                ("humidity.fill", "Humidity :", String(storiedCurrentWeatherReport.relativeHumidity)),
                ("info.circle", "Info :", storiedCurrentWeatherReport.text ?? "No data provided")
            ]
        } else if let currentReport = weatherReport?.report.conditions {
            return [
                ("thermometer.low", "Temperature :", String(currentReport.tempC)),
                ("tirepressure", "Pressure HG :", String(currentReport.pressureHg)),
                ("tirepressure", "Pressure HPA :", String(currentReport.pressureHpa)),
                ("humidity.fill", "Humidity :", String(currentReport.relativeHumidity)),
                ("info.circle", "Info :", currentReport.text)
            ]
        }
        return []
    }
    
    func forecastDetailLabelConfigurations() -> [(symbolName: String, title: String, text: String)] {
        if let storiedForecastReport = storiedForecastReport {
            return [
                ("info.circle", "Identity : ", storiedForecastReport.ident ?? "No data provided"),
                ("mappin", "Latitude : ", String(storiedForecastReport.lat)),
                ("mappin", "Longitude : ", String(storiedForecastReport.lon)),
                ("quotelevel", "Elevation FT : ", String(storiedForecastReport.elevationFt)),
                ("calendar.circle", "Start Date : ", String(storiedForecastReport.period?.dateStart ?? "No data provided")),
                ("calendar.circle", "End Date : ", String(storiedForecastReport.period?.dateEnd ?? "No data provided")),
                ("info.circle", "Info : ", String(storiedForecastReport.text ?? "No data provided")),
            ]
        } else if let forecastReport = weatherReport?.report.forecast {
            return [
                ("info.circle", "Identity : ", forecastReport.ident),
                ("mappin", "Latitude : ", String(forecastReport.lat)),
                ("mappin", "Longitude : ", String(forecastReport.lon)),
                ("quotelevel", "Elevation FT : ", String(forecastReport.elevationFt)),
                ("calendar.circle", "Start Date : ", String(forecastReport.period.dateStart)),
                ("calendar.circle", "End Date : ", String(forecastReport.period.dateEnd)),
                ("info.circle", "Info : ", String(forecastReport.text)),
            ]
        }
        return []
    }
}

