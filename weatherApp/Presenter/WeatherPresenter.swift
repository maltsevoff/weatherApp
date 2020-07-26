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
		requestUserLocation()
		fetchNote()
	}
	
	private func requestUserLocation() {
		locationManager.requestAlwaysAuthorization()
		locationManager.startUpdatingLocation()
		locationManager.delegate = self
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
