//
//  LocationWeather.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationWeather: Codable {
	let name: String
	let cod: Int
	let country: Country
	let temperature: Temperature
	
	enum CodingKeys: String, CodingKey {
		case name
		case cod
		
		case country = "sys"
		case temperature = "main"
	}
}
