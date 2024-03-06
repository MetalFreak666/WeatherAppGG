//
//  LocationsSubmitView.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import UIKit
import SnapKit

class LocationSubmitView: UIView {
    
    // MARK: - Properties
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter airport location"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Search"
        config.baseBackgroundColor = .gray
        config.baseForegroundColor = .white
        config.buttonSize = .large
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSearchButton), for: .touchDown)
        
        return button
    }()
    
    private lazy var locationStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 18
        
        return view
    }()
    
    var submitAction: ((String?) -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup views and view layouts
    private func setupView() {
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(locationStackView)
        locationStackView.addArrangedSubview(textField)
        locationStackView.addArrangedSubview(submitButton)
    }
    
    private func setupLayoutConstraints() {
        locationStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(18)
            make.bottom.equalTo(submitButton.snp.top).offset(-18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
        
        submitButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(textField.snp.bottom).offset(18)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
        }
    }
    
    @objc func didTapSearchButton(sender: UIButton) {
        submitAction?(textField.text)
    }
}
