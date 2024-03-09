//
//  LocationsListViewController.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import UIKit
import SnapKit

class LocationsListViewController: UIViewController, UITableViewDelegate {
    
    // MARK: - Properties
    private let submitView = LocationSubmitView()
    private let viewModel = LocationsViewModel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    private let tableView = UITableView()
    private let cellReuseIdentifier = "CustomLocationCell"
    private var lastLocations: [LastSearchLocation] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var storiedLocation: [AirportLocation]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Airport locations"
        
        setupView()
        setupLayoutConstraints()
        setupTableView()
        loadingIndicator.startAnimating()
        submitView.submitAction = { locationText in
            if let location = locationText, !location.isEmpty {
                self.loadingIndicator.startAnimating()
                self.fetchForecast(for: location)
            } else {
                self.showEmptyLocationAlert()
            }
        }
        
        //lastLocations = viewModel.getLastLocations()
        fetchLastAirportLocationsFromStorage()
    }
    
    // MARK: - Setup views and view layouts
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(submitView)
        self.view.addSubview(tableView)
        self.view.addSubview(loadingIndicator)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    private func setupLayoutConstraints() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.bottom.equalTo(submitView.snp.top).offset(-18)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        submitView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.bringSubviewToFront(loadingIndicator)
    }
    
    // MARK: - Navigation
    private func navigateToDetailView(with selectedItem: WeatherReport?) {
        let detailVC = DetailViewController()
        let viewModel = LocationDetailViewModel()
        viewModel.weatherReport = selectedItem
        detailVC.viewModel = viewModel
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Alerts
extension LocationsListViewController {
    private func showEmptyLocationAlert() {
        let alert = UIAlertController(title: "Warning!", message: "You need to provide location first", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    private func showFailedRequestAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
}

// MARK: - API
extension LocationsListViewController {
    private func fetchForecast(for airportId: String) {
        viewModel.getLocationForecast(airportId: airportId) { forecastReport, error in
            self.loadingIndicator.stopAnimating()
            
            if let error = error {
                self.showFailedRequestAlert(errorMessage: error.localizedDescription)
            } else {
                self.addAirportLocationsToStorage(airportId: airportId)
                self.navigateToDetailView(with: forecastReport)
            }
        }
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension LocationsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! LocationTableViewCell
        let item = lastLocations[indexPath.row]
        cell.configure(symbol: UIImage(systemName: item.iconName), title: item.lastLocationTitle, subtitle: item.lastLocationDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        #warning("DAORA: FIX ME")
        let selectedLocation = lastLocations[indexPath.row]
        navigateToDetailView(with: nil)
    }
    
    #warning("DAORA: WIP")
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let personToRemove = self.lastLocations[indexPath.row]
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: - CoreData
extension LocationsListViewController {
    func fetchLastAirportLocationsFromStorage() {
        do {
            self.storiedLocation = try context.fetch(AirportLocation.fetchRequest())
            
            if let lastStoriedLocations = self.storiedLocation {
                for storiedLocation in lastStoriedLocations {
                    let location: LastSearchLocation = .init(iconName: "airplane",
                                                             lastLocationTitle: storiedLocation.airportCode ?? "No data provided",
                                                             lastLocationDate: storiedLocation.lastFetchDate ?? "No data provided"
                    )
                    lastLocations.append(location)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Could not fetch airport locations...")
        }
    }
    
    func addAirportLocationsToStorage(airportId: String) {
        let newSearchLocation = AirportLocation(context: self.context)
        newSearchLocation.airportCode = airportId
        newSearchLocation.lastFetchDate = getTimestampt()
        
        do {
            try self.context.save()
        } catch {
            print("Error with saving to the storage")
        }
    }
    
    func deleteAirportLocationFromTheStorage() {
        //TODO: Not implemented yet
    }
}

//MARK: - DateFormatter
extension LocationsListViewController {
    private func getTimestampt() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }
}
