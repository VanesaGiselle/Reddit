//
//  WeatherViewController.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 08/05/2023.
//

import UIKit

class WeatherViewController: UIViewController {
    private let cityCoordinates = (-34.6518, -58.6788)
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tempMinLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tempMaxLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var visibilityLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(12)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cityLabel,
            titleLabel,
            descriptionLabel,
            tempLabel,
            feelsLikeLabel,
            tempMinLabel,
            tempMaxLabel,
            pressureLabel,
            humidityLabel,
            visibilityLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeather()
        setup()
    }
    
    private func render(_ weather: Weather) {
        cityLabel.text = weather.city
        titleLabel.text = weather.title
        descriptionLabel.text = weather.description
        tempLabel.text = "Temp: \(String(describing: weather.temp))"
        feelsLikeLabel.text = "Feels Like: \(String(describing: weather.feelsLike))"
        tempMinLabel.text = "Temp Min: \(String(describing: weather.tempMin))"
        tempMaxLabel.text = "Temp Max: \(String(describing: weather.tempMax))"
        pressureLabel.text = "Pressure: \(String(describing: weather.pressure))"
        humidityLabel.text = "Humidity: \(String(describing: weather.humidity))"
        visibilityLabel.text = "Visibility: \(String(describing: weather.visibility))"
    }
    
    private func setup() {
        view.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func getWeather() {
        HttpConnector().getWeather(completionHandler: {
            [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                self.render(weather)
            case.failure(let error):
                self.handleFailure(error)
            }
        }, lat: String(cityCoordinates.0), lon: String(cityCoordinates.1))
    }
}
