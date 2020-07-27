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
	func newNote(_ note: String?)
	func locationManagerDenide()
}

class WeatherPresenter: NSObject {
	
	private let locationManager = CLLocationManager()
	private let api = WeatherApiRequests()
	private let noteManager = NotesManager()
	
	weak var delegate: WeatherPresenterDelegate?
	
	override init() {
		super.init()
	}
	
	func start() {
		checkLocation()
		fetchNote()
	}
	
	private func requestUserLocation() {
		locationManager.requestAlwaysAuthorization()
		locationManager.startUpdatingLocation()
		locationManager.delegate = self
	}
	
	private func checkLocation() {
		if CLLocationManager.locationServicesEnabled() {
			switch CLLocationManager.authorizationStatus() {
			case .authorizedAlways, .authorizedWhenInUse:
				requestWeather()
			default:
				requestUserLocation()
			}
		}
	}
	
	func updateNote(_ note: String?) {
		saveNote(note)
		fetchNote()
	}
	
	private func saveNote(_ note: String?) {
		self.noteManager.saveNote(note)
	}
	
	private func fetchNote() {
		let note = self.noteManager.fetchNote()
		self.delegate?.newNote(note)
	}
	
	private func locationIsDenied() {
		self.delegate?.locationManagerDenide()
	}
	
	private func requestWeather() {
		if let location = locationManager.location {
			api.getWeatherFor(lat: location.coordinate.latitude,
							  lon: location.coordinate.longitude, handler: { locationWeather in
								DispatchQueue.main.async {
									self.delegate?.newLocationWeather(locationWeather)
								}
			})
		}
	}
	
}

extension WeatherPresenter: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		switch status {
		case .authorizedAlways, .authorizedWhenInUse:
			requestWeather()
		default:
			locationIsDenied()
		}
	}
}
