//
//  Condition.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation

struct Condition: Codable {
    struct CloudLayer: Codable {
        let altitudeFt: Int
        let coverage: String
        let ceiling: Bool
    }

    let cloudLayers: [CloudLayer]
    let period: Period
    let flightRules: String
    let dateIssued: String
    let wind: Wind
    //let visibility: Visibility
    let relativeHumidity: Int
    let lon: Double
    let text: String
    let elevationFt: Int
    let weather: [String]
    let cloudLayersV2: [CloudLayer]
    let lat: Double

    struct Period: Codable {
        let dateEnd: String
        let dateStart: String
    }

    struct Wind: Codable {
        let speedKts: Int
        let from: Int
        let direction: Int
        let variable: Bool
    }
    
    #warning("DAORA: Not working")
    struct Visibility: Codable {
        let prevailingVisDistanceQualifier: Int
        let distanceSm: Int
        let distanceQualifier: Int
        let prevailingVisSm: Int
    }
}
