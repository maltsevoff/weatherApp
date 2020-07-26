//
//  Country.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import Foundation

struct Country: Codable {
	
	let id: Int
	let name: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case name = "country"
	}
}
