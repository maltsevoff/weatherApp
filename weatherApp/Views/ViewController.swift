//
//  ViewController.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBAction func backgroundTapped(_ sender: UIButton) {
		print("tapped")
	}
	
	private let weatherPresenter = WeatherPresenter()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		weatherPresenter.delegate = self
		weatherPresenter.requestUserLocation()
	}

	private func setWeather(_ locationWeather: LocationWeather) {
		self.cityNameLabel.text = locationWeather.name
		self.countryNameLabel.text = locationWeather.country.name
		let tempToShow = Int(locationWeather.temperature.real)
		self.temperatureLabel.text = "\(tempToShow)°"
	}
}

extension ViewController: WeatherPresenterDelegate {
	func newLocationWeather(_ locationWeather: LocationWeather?) {
		if let weather = locationWeather {
			self.setWeather(weather)
		}
	}
}

