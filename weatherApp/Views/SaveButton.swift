//
//  SaveButton.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class SaveButton: UIButton {
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		isHidden = true
		configure()
	}
	
	private func configure() {
		backgroundColor = .black
		setTitle("Save", for: .normal)
		titleLabel?.textColor = .white
		titleLabel?.textAlignment = .center
		layer.cornerRadius = 10
	}
	
	func show() {
		isHidden = false
	}
}
