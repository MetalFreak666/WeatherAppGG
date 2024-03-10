//
//  LocationTableViewCell.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 06/03/2024.
//

import UIKit
import SnapKit

class LocationTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupViewLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup views and view layouts
    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func setupViewLayouts() {
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
        }
        
        locationTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-18)
        }
        
    }
    
    func configure(symbol: UIImage?, title: String, subtitle: String) {
        iconImageView.image = symbol
        locationTitleLabel.text = title
        dateLabel.text = subtitle
    }
}
