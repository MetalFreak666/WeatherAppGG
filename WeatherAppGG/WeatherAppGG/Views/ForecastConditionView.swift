//
//  LocationForecastDetailView.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 08/03/2024.
//

import UIKit
import SnapKit

class ForecastConditionView: UIView {
    
    // MARK: Properties
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        label.tintColor = .gray
        return label
    }()
    
    private let textLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    private let forecastStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayoutConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        /*
        NSLayoutConstraint.activate([
            forecastStackView.topAnchor.constraint(equalTo: topAnchor),
            forecastStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            forecastStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            forecastStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])*/
    }
    
    func configure(condition: Condition?) {
        //guard let condition = condition else { return }
        iconImageView.image = UIImage(systemName: "sun.min.fill")
        titleLabel.text = "Wind"
        textLabel.text = "Strong"
        
        
        
    }
}
