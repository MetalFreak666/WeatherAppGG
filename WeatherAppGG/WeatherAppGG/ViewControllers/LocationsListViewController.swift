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
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Airport locations"
        
        setupView()
        setupLayoutConstraints()
        setupTableView()
        setupInitialData()
        loadingIndicator.startAnimating()
        submitView.submitAction = { locationText in
            if let location = locationText, !location.isEmpty {
                self.loadingIndicator.startAnimating()
                self.fetchForecast(for: location)
            } else {
                self.showEmptyLocationAlert()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadTableViewData()
    }
    
    // MARK: - Setup views and view layouts
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(submitView)
        self.view.addSubview(tableView)
        self.view.addSubview(loadingIndicator)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(tableView)
        self.tableView.frame = view.bounds
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
    
    private func setupInitialData() {
        self.viewModel.fetchLastAirportLocationsFromStorage(context: context) { error in
            if let error {
                self.showFailedRequestToStorageAlert(errorMessage: error.localizedDescription)
            } else {
                self.reloadTableViewData()
            }
        }
    }
    
    // MARK: - Navigation
    private func navigateToDetailView(with weatherReport: WeatherReport?) {
        let detailVC = DetailViewController()
        let viewModel = LocationDetailViewModel()
        viewModel.weatherReport = weatherReport
        detailVC.viewModel = viewModel
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func navigateToDetailViewWithLocation(with selectedLocation: AirportLocation) {
        let detailVC = DetailViewController()
        let viewModel = LocationDetailViewModel()
        viewModel.storiedCurrentWeatherReport = selectedLocation.currentReport
        viewModel.storiedForecastReport = selectedLocation.forecastReport
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
    
    private func showFailedRequestToStorageAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Something went wrong!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
}

// MARK: - API
extension LocationsListViewController {
    private func fetchForecast(for airportId: String) {
        viewModel.getLocationForecast(airportId: airportId) { weatherReport, error in
            self.loadingIndicator.stopAnimating()
            
            if let error = error {
                self.showFailedRequestAlert(errorMessage: error.localizedDescription)
            } else {
                if let report = weatherReport {
                    self.viewModel.addAirportWeatherReportToStorage(context: self.context, airportId: airportId, weatherReport: report) { error in
                        if let error {
                            self.showFailedRequestToStorageAlert(errorMessage: error.localizedDescription)
                        }
                    }
                }
                self.navigateToDetailView(with: weatherReport)
            }
        }
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension LocationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.storiedAirportLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! LocationTableViewCell
        let item = viewModel.storiedAirportLocations[indexPath.row]
        cell.configure(symbol: UIImage(systemName: "airplane"), title: item.airportCode, subtitle: item.lastFetchDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedLocation = viewModel.storiedAirportLocations[indexPath.row]
        navigateToDetailViewWithLocation(with: selectedLocation)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let locationToRemove = self.viewModel.storiedAirportLocations[indexPath.row]
            self.context.delete(locationToRemove)
            
            do {
                try self.context.save()
            } catch {
                self.showFailedRequestToStorageAlert(errorMessage: "Could not remove location from the storage!")
            }
            self.reloadTableViewData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.bounds.width - 30, height: 40))
        label.text = "Last fetched locations"
        label.textColor = .black
        headerView.addSubview(label)
        
        return headerView
    }
    
    func reloadTableViewData() {
        do {
            self.viewModel.storiedAirportLocations = try context.fetch(AirportLocation.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            self.showFailedRequestToStorageAlert(errorMessage: "Could not update TableView data!!")
        }
    }
}
