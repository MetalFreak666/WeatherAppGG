//
//  AlamofireWeatherForecastHTTPClient.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityLogger

struct AlamofireWeatherForecastHTTPClient: WeatherForecastHTTPClient {
    let baseURL: String = "https://qa.foreflight.com/weather"
    
    func getWeatherForecast(aiportId: String, completion: @escaping (WeatherReport?, Error?) -> Void) {
        let path = "\(baseURL)/report/\(aiportId)"
        let httpHeaders: HTTPHeaders = ["ff-coding-exercise": "1"]
        let method: HTTPMethod = .get
        
        AF.request(path, method: method, headers: httpHeaders)
            .logResponse(.verbose)
            .responseData { reponse in
                
                switch reponse.result {
                case .failure(let error):
                    completion(nil, error)
                case .success(let data):
                    let jsonData = data
                    
                    do {
                        let forecastReport = try JSONDecoder().decode(WeatherReport.self, from: jsonData)
                        completion(forecastReport, nil)
                    } catch {
                        print("ERROR: \(error)")
                        completion(nil, error)
                    }
                }
            }
    }
}
