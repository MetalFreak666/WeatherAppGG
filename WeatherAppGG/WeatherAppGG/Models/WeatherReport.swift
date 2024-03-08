//
//  WeatherReport.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation

struct WeatherReport: Codable {
    let report: Report
}

struct Report: Codable {
    let forecast: Forecast
    let conditions: CurrentCondition
}
