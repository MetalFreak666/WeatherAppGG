//
//  LocationsListViewController.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import UIKit
import SnapKit

class LocationsListViewController: UIViewController {
    
    private let submitView = LocationSubmitView()
    private let viewModel = LocationsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Airport locations"
        
        setupView()
        setupLayoutConstraints()
        submitView.submitAction = { locationText in
            if let location = locationText, !location.isEmpty {
                self.fetchForecast(for: location)
            } else {
                self.showEmptyLocationAlert()
            }
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(submitView)
    }
    
    private func setupLayoutConstraints() {
        submitView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
    }

}

//MARK: Alerts

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

//MARK: API

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
