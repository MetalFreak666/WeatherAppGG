//
//  LocationsListViewController.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import UIKit
import SnapKit

class LocationsListViewController: UIViewController {
    
    // MARK: - Properties
    private let submitView = LocationSubmitView()
    private let viewModel = LocationsViewModel()
    
    private let tableView = UITableView()
    private let cellReuseIdentifier = "CustomLocationCell"
    private var lastLocations: [LastSearchLocation] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Airport locations"
        
        setupView()
        setupLayoutConstraints()
        setupTableView()
        submitView.submitAction = { locationText in
            if let location = locationText, !location.isEmpty {
                self.fetchForecast(for: location)
            } else {
                self.showEmptyLocationAlert()
            }
        }
        
        lastLocations = viewModel.getLastLocations()
    }
    
    // MARK: - Setup views and view layouts
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(submitView)
        self.view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    private func setupLayoutConstraints() {
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
    private func fetchForecast(for aiportId: String) {
        viewModel.getLocationForecast(airportId: aiportId) { forecastReport, error in
            if let error = error {
                self.showFailedRequestAlert(errorMessage: error.localizedDescription)
            } else {
                //TODO: Update view
            }
        }
    }
}

// MARK: - UITableViewDataSource
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
}
