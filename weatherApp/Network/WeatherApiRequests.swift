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
	private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
	
	func getWeatherFor(lat: Double, lon: Double, handler: @escaping ()->()) {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.openweathermap.org"
		components.path = "/data/2.5/weather"
		components.queryItems = [
			URLQueryItem(name: "lat", value: "\(lat)"),
			URLQueryItem(name: "lon", value: "\(lon)"),
			URLQueryItem(name: "appid", value: self.apiKey)
		]
		guard let url = components.url else {
			handler()
			return
		}
		
		let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { data, res, error in
			if let data = data {
				let str = String(data: data, encoding: .utf8)
				print(str)
			} else {
				handler()
			}
		}
		
		task.resume()
	}
}
