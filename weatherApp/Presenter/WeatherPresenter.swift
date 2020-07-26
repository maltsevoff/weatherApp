//
//  WeatherPresenter.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherPresenterDelegate: class {
	func newLocationWeather(_ locationWeather: LocationWeather?)
}

class WeatherPresenter: NSObject {
	
	private let locationManager = CLLocationManager()
	private let api = WeatherApiRequests()
	
	weak var delegate: WeatherPresenterDelegate?
	
	override init() {
		super.init()
	}
	
	func requestUserLocation() {
		locationManager.requestAlwaysAuthorization()
		locationManager.startUpdatingLocation()
		locationManager.delegate = self
	}
	
}

extension WeatherPresenter: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedAlways, .authorizedWhenInUse:
			if let location = locationManager.location {
				api.getWeatherFor(lat: location.coordinate.latitude,
								  lon: location.coordinate.longitude, handler: { locationWeather in
									print(locationWeather)
									DispatchQueue.main.async {
										self.delegate?.newLocationWeather(locationWeather)
									}
				})
			}
		default:
			print("location is blocked")
		}
	}
}
