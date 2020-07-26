//
//  Temperature.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import Foundation

struct Temperature: Codable {
	let real: Float
	let feelsLike: Float
	
	enum CodingKeys: String, CodingKey {
		case real = "temp"
		case feelsLike = "feels_like"
	}
}
