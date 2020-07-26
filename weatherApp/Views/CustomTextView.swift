//
//  CustomTextInput.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		layer.cornerRadius = 10
		layer.masksToBounds = true
		backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
		isHidden = true
	}
	
	func getTextAndClean() -> String {
		let str = text
		text = ""
		return str ?? ""
	}

}
