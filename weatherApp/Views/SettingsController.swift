//
//  SettingController.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
	
	static var identifier: String { "SettingsControllerID" }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = false
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.navigationBar.isHidden = true
	}
}
