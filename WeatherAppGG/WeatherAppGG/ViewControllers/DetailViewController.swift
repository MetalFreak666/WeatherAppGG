//
//  DetailViewController.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 08/03/2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let conditionView = LocationConditionView()
    private let forecastView = LocationForecastView()
    
    private lazy var segmentedControl: UISegmentedControl = { [weak self] in
        guard let self = self else {
            fatalError("Unable to capture self weakly")
        }
        
        let segmentedControl = UISegmentedControl(items: ["Conditions", "Forecast"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Conditions"
        
        setupView()
        setupLayoutConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(segmentedControl)
        self.view.addSubview(conditionView)
        self.view.addSubview(forecastView)
    }
    
    private func setupLayoutConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        conditionView.translatesAutoresizingMaskIntoConstraints = false
        forecastView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.widthAnchor.constraint(equalToConstant: 300),

            conditionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            conditionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conditionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            forecastView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            forecastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension DetailViewController {
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Update UI based on selected segment
        switch sender.selectedSegmentIndex {
        case 0:
            title = sender.titleForSegment(at: sender.selectedSegmentIndex)
            displayWeatherConditions()
        case 1:
            title = sender.titleForSegment(at: sender.selectedSegmentIndex)
            displayWeatherForecast()
        default:
            break
        }
    }
    
    private func displayWeatherConditions() {
        forecastView.isHidden = true
        conditionView.isHidden = false
        
    }
    
    private func displayWeatherForecast() {
        forecastView.isHidden = false
        conditionView.isHidden = true
    }
}
