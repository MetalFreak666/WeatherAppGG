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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Conditions"

        setupView()
        setupLayoutConstraints()
        configureCurrentDetailStackView()
    }
    
    // MARK: - Setup views and view layouts
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
        let labelConfigurations = viewModel?.weatherDetailLabelConfigurations() ?? []
        
        for config in labelConfigurations {
            let label = WeatherDetailLabel()
            label.configure(symbolName: config.symbolName, title: config.title, text: config.text)
            detailStackView.addArrangedSubview(label)
        }
    }
    
    private func configureForecastDetailStackView() {
        let labelConfigurations = viewModel?.forecastDetailLabelConfigurations() ?? []
        
        for config in labelConfigurations {
            let label = WeatherDetailLabel()
            label.configure(symbolName: config.symbolName, title: config.title, text: config.text)
            detailStackView.addArrangedSubview(label)
        }
    }
}

//MARK: - Segmented control
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
