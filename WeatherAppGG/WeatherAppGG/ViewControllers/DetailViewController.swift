//
//  DetailViewController.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 08/03/2024.
//

import UIKit
import SnapKit
import SwiftUI

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var segmentedControl: UISegmentedControl = { [weak self] in
        guard let self = self else {
            fatalError("Unable to capture self weakly")
        }
        
        let segmentedControl = UISegmentedControl(items: ["Conditions", "Forecast"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 18
        return stackView
    }()
    
    private let swiftUIViewContainer = UIView()
    
    var viewModel: LocationDetailViewModel?
    var weatherReport: WeatherReport?


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Conditions"

        setupView()
        setupLayoutConstraints()
        configureCurrentDetailStackView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(segmentedControl)
        self.view.addSubview(swiftUIViewContainer)
        self.view.addSubview(detailStackView)
    }
    
    private func setupLayoutConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        swiftUIViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.widthAnchor.constraint(equalToConstant: 300),

            swiftUIViewContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            swiftUIViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            swiftUIViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            swiftUIViewContainer.heightAnchor.constraint(equalToConstant: 200),
  
            detailStackView.topAnchor.constraint(equalTo: swiftUIViewContainer.bottomAnchor, constant: 20),
            detailStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        initSwiftUIView()

    }
    
    private func initSwiftUIView() {
        let forecastScrollView = ForecastScrollView(conditions: viewModel?.initForecastConditions() ?? [])
        let hostingController = UIHostingController(rootView: forecastScrollView)
        addChild(hostingController)
        swiftUIViewContainer.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.frame = swiftUIViewContainer.bounds
        hostingController.didMove(toParent: self)
    }
    
    private func configureCurrentDetailStackView() {
        if let storiedCurrentWeatherReport = viewModel?.storiedCurrentWeatherReport {
            let labelConfig: [(symbolName: String, title: String, text: String)] = [
                ("thermometer.low", "Temperature :", String(storiedCurrentWeatherReport.tempC)),
                ("tirepressure", "Pressure HG :", String(storiedCurrentWeatherReport.pressureHg)),
                ("tirepressure", "Pressure HPA :", String(storiedCurrentWeatherReport.pressureHpa)),
                ("humidity.fill", "Humidity :", String(storiedCurrentWeatherReport.relativeHumidity)),
                ("info.circle", "Info :", storiedCurrentWeatherReport.text ?? "No data provided")
            ]
            
            for config in labelConfig {
                let label = WeatherDetailLabel()
                label.configure(symbolName: config.symbolName, title: config.title, text: config.text)
                detailStackView.addArrangedSubview(label)
            }
        } else {
            guard let currentReport = viewModel?.weatherReport?.report.conditions else { return }
            
            let labelConfig: [(symbolName: String, title: String, text: String)] = [
                ("thermometer.low", "Temperature :", String(currentReport.tempC)),
                ("tirepressure", "Pressure HG :", String(currentReport.pressureHg)),
                ("tirepressure", "Pressure HPA :", String(currentReport.pressureHpa)),
                ("humidity.fill", "Humidity :", String(currentReport.relativeHumidity)),
                ("info.circle", "Info :", currentReport.text)
            ]
            
            for config in labelConfig {
                let label = WeatherDetailLabel()
                label.configure(symbolName: config.symbolName, title: config.title, text: config.text)
                detailStackView.addArrangedSubview(label)
            }
        }
    }
    
    private func configureForecastDetailStackView() {
        if let storiedForecastReport = viewModel?.storiedForecastReport {
            let labelConfig: [(symbolName: String, title: String, text: String)] = [
                ("info.circle", "Identity : ", storiedForecastReport.ident ?? "No data provided"),
                ("mappin", "Latitude : ", String(storiedForecastReport.lat)),
                ("mappin", "Longitude : ", String(storiedForecastReport.lon)),
                ("quotelevel", "Elevation FT : ", String(storiedForecastReport.elevationFt)),
                ("calendar.circle", "Start Date : ", String(storiedForecastReport.period?.dateStart ?? "No data provided")),
                ("calendar.circle", "End Date : ", String(storiedForecastReport.period?.dateEnd ?? "No data provided")),
                ("info.circle", "Info : ", String(storiedForecastReport.text ?? "No data provided")),
            ]
            
            for config in labelConfig {
                let label = WeatherDetailLabel()
                label.configure(symbolName: config.symbolName, title: config.title, text: config.text)
                detailStackView.addArrangedSubview(label)
            }
        } else {
            guard let forecastReport = viewModel?.weatherReport?.report.forecast else { return }
            let labelConfig: [(symbolName: String, title: String, text: String)] = [
                ("info.circle", "Identity : ", forecastReport.ident),
                ("mappin", "Latitude : ", String(forecastReport.lat)),
                ("mappin", "Longitude : ", String(forecastReport.lon)),
                ("quotelevel", "Elevation FT : ", String(forecastReport.elevationFt)),
                ("calendar.circle", "Start Date : ", String(forecastReport.period.dateStart)),
                ("calendar.circle", "End Date : ", String(forecastReport.period.dateEnd)),
                ("info.circle", "Info : ", String(forecastReport.text)),
            ]
            
            for config in labelConfig {
                let label = WeatherDetailLabel()
                label.configure(symbolName: config.symbolName, title: config.title, text: config.text)
                detailStackView.addArrangedSubview(label)
            }
        }
    }
}

extension DetailViewController {
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
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
        clearDetailView()
        configureCurrentDetailStackView()
    }
    
    private func displayWeatherForecast() {
        clearDetailView()
        configureForecastDetailStackView()
    }
    
    private func clearDetailView() {
        detailStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
