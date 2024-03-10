//
//  ConditionLight.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 09/03/2024.
//

import Foundation

struct ConditionLight {
    let id: UUID
    let period: Period
    let lon: Double
    let lat: Double
    let relativeHumidity: Int
}
