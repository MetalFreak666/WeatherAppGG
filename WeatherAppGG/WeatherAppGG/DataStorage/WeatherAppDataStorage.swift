//
//  WeatherAppDataStorage.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 09/03/2024.
//

import Foundation
import CoreData

class WeatherAppDataStorage {
    static let shared = WeatherAppDataStorage()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AirportLocationDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Failed to save Core Data context: \(error)")
            }
        }
    }
    
    /*
    func fetchWeatherReport(for airportCode: String) -> WeatherReport? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<AirportLocation> = AirportLocation.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "code == %@", airportCode)
        fetchRequest.fetchLimit = 1
        
        do {
            if let airport = try context.fetch(fetchRequest).first {
                return airport.forecastReport
            }
        } catch {
            print("Failed to fetch airport: \(error)")
        }
        
        return nil
    }
    
    func cacheWeatherReport(_ weatherReport: WeatherReport, for airportCode: String) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<AirportLocation> = AirportLocation.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "code == %@", airportCode)
        fetchRequest.fetchLimit = 1
        
        do {
            if let airport = try context.fetch(fetchRequest).first {
                airport.weatherReport = weatherReport
                saveContext()
            } else {
                let airport = Airport(context: context)
                airport.code = airportCode
                airport.weatherReport = weatherReport
                saveContext()
            }
        } catch {
            print("Failed to cache weather report: \(error)")
        }
    }*/
}
