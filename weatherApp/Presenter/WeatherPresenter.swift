//
//  WeatherPresenter.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherPresenter: NSObject {
	
	private let locationManager = CLLocationManager()
	
	override init() {
		super.init()
		locationManager.requestAlwaysAuthorization()
		locationManager.startUpdatingLocation()
		locationManager.delegate = self
	}
	
}

extension WeatherPresenter: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			print(location)
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedAlways, .authorizedWhenInUse:
			print(locationManager.location)
		default:
			print("location is blocked")
		}
	}
}
