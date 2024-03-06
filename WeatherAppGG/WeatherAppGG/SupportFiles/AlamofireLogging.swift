//
//  AlamofireLogging.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Response logging
extension DataRequest {

    /// The response logging level. `.simple` prints only the HTTP status code and path; `.verbose` prints the response body as well.
    public enum ResponseLogLevel {
        /// Print the response's HTTP status code and path, or error if one is returned.
        case simple
        /// Print the response's HTTP status code, path, and body, or error if one is returned.
        case verbose
    }

    /// Log the response at the specified `level`.
    public func logResponse(_ level: ResponseLogLevel = .simple) -> Self {
        
        /*
        guard Config.isLoggingEnabled else {
            return self
        }*/

        return response { response in
            guard
                let request = response.request,
                let httpMethod = request.httpMethod,
                let urlPath = request.url?.absoluteString,
                let responseCode = response.response?.statusCode else {
                return
            }

            print("----------------------------------")
            print("REQUEST - \(httpMethod): \(urlPath)")

            if let data = request.httpBody,
               let body = String(data: data, encoding: .utf8) {
                if let jsonBody = JSON(parseJSON: body).rawString(), jsonBody != "null" {
                    print("\(jsonBody)")
                } else {
                    print("\(body)")
                }
            }

            print("RESPONSE - \(responseCode)")

            if case .verbose = level, let data = response.data, let body = String(data: data, encoding: .utf8) {
                if let jsonBody = JSON(parseJSON: body).rawString(), jsonBody != "null" {
                    print("\(jsonBody)")
                } else {
                    print("\(body)")
                }

            }
            print("\nNetwork travel time: \(String(format: "%.2f", response.metrics?.taskInterval.duration ?? 0)) sec")
            print("----------------------------------")
        }
    }
}
