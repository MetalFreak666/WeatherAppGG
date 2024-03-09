//
//  Forecast.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation

struct Forecast: Codable {
    let conditions: [Condition]
    let text: String
    let ident: String
    let lat: Double
    let elevationFt: Int
    let dateIssued: String
    let lon: Double
    let period: Period
}

struct Period: Codable {
    let dateEnd: String
    let dateStart: String
}
