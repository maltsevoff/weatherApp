//
//  WeatherApiRequests.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import Foundation

class WeatherApiRequests {
	
	private let apiKey = "ddf092ab637dc23d73d74119d5246879"
	private let host = "api.openweathermap.org"
	private let weatherPath = "/data/2.5/weather"
	
	func getWeatherFor(lat: Double, lon: Double, handler: @escaping (LocationWeather?)->()) {
		guard let url = urlFor(lat: lat, lon: lon) else {
			handler(nil)
			return
		}
		
		let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { data, res, error in
			if let data = data {
				let decoder = JSONDecoder()
				let json = try? decoder.decode(LocationWeather.self, from: data)
				handler(json)
			} else {
				handler(nil)
			}
		}
		task.resume()
	}
	
	private func urlFor(lat: Double, lon: Double) -> URL? {
		var components = URLComponents()
		components.scheme = "https"
		components.host = self.host
		components.path = weatherPath
		components.queryItems = [
			URLQueryItem(name: "lat", value: "\(lat)"),
			URLQueryItem(name: "lon", value: "\(lon)"),
			URLQueryItem(name: "units", value: "metric"),
			URLQueryItem(name: "appid", value: self.apiKey)
		]
		return components.url
	}
}
