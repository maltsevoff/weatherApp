//
//  UIViewExtension.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit

extension UIView {
	func showOrHide() {
		isHidden.toggle()
	}
	
	func hide() {
		isHidden = true
	}
}
