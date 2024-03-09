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
    //private let conditionView = LocationConditionStackView()
    private let forecastView = ForecastView()
    
    var stackView = UIStackView()
    
    var viewModel: LocationDetailViewModel?
    var weatherReport: WeatherReport?
    
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
        configureStackView()
        setupLayoutConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(segmentedControl)
        self.view.addSubview(forecastView)
    }
    
    private func setupLayoutConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.widthAnchor.constraint(equalToConstant: 300),
            
            stackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 18
    }
    
    private func reloadWeatherDetailData() {
        let airportIdLabel = LocationConditionLabel()
        airportIdLabel.configure(symbolName: "airplane", title: "Airport ID", text: viewModel?.weatherReport?.report.conditions.text ?? "")
        stackView.addArrangedSubview(airportIdLabel)
    }
    
    private func reloadForecastDetailsData() {
        
    }
    
}

extension DetailViewController {
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Update UI based on selected segment
        switch sender.selectedSegmentIndex {
        case 0:
            title = sender.titleForSegment(at: sender.selectedSegmentIndex)
            //reloadWeatherDetailData()
            displayWeatherConditions()
        case 1:
            title = sender.titleForSegment(at: sender.selectedSegmentIndex)
            //reloadForecastDetailsData()
            displayWeatherForecast()
        default:
            break
        }
    }
    
    private func displayWeatherConditions() {
        forecastView.isHidden = true
        //conditionView.isHidden = false
        
    }
    
    private func displayWeatherForecast() {
        forecastView.isHidden = false
        stackView.addArrangedSubview(forecastView)
        //conditionView.isHidden = true
    }
}
