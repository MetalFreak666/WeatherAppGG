//
//  CurrentCondition.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 08/03/2024.
//

import Foundation

struct CurrentCondition: Codable {
    let ident: String
    let remarks: Remarks?
    let lon: Double
    let lat: Double
    let reportASHpa: Bool?
    let tempC: Int
    let weather: [String]
    let relativeHumidity: Int
    let flightRules: String
    let cloudLayers: [CloudLayer]?
    let cloudLayersV2: [CloudLayer]?
    let pressureHpa: Double
    let pressureHg: Double
    let dateIssued: String
    let visibility: Visibility?
    let dewpointC: Int
    let wind: Wind?
    let elevationFt: Int
    let text: String
    let densityAltitudeFt: Double
    
    struct Remarks: Codable {
        let humanObserver: Bool?
        let temperature: Double?
    }
    
    struct CloudLayer: Codable {
        let altitudeFt: Int?
        let coverage: String?
        let ceiling: Bool?
    }
    
    struct Visibility: Codable {
        let prevailingVisDistanceQualifier: Int?
        let distanceSm: Int?
        let distanceQualifier: Int?
        let prevailingVisSm: Int?
    }
    
    struct Wind: Codable {
        let speedKts: Double?
        let from: Int?
        let direction: Int?
        let variable: Bool?
    }
}
