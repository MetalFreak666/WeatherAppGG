//
//  WeatherForecastHTTPClient.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation

protocol WeatherForecastHTTPClient {
    func getWeatherForecast(aiportId: String, completion: @escaping(_ forecast: WeatherReport?, _ error: Error?) -> Void)
}
