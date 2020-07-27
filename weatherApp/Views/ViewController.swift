//
//  ViewController.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var countryNameLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var textView: CustomTextView!
	@IBOutlet weak var saveButton: SaveButton!
	@IBOutlet weak var noteLabel: UILabel!
	@IBAction func backgroundTapped(_ sender: UIButton) {
		showTextView()
	}
	@IBAction func saveButtonPressed(_ sender: SaveButton) {
		hideTextView()
	}
	
	private let weatherPresenter = WeatherPresenter()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		weatherPresenter.delegate = self
		weatherPresenter.start()
		navigationController?.navigationBar.isHidden = true
	}

	private func setWeather(_ locationWeather: LocationWeather) {
		self.cityNameLabel.text = locationWeather.name
		self.countryNameLabel.text = locationWeather.country.name
		let tempToShow = Int(locationWeather.temperature.real)
		self.temperatureLabel.text = "\(tempToShow)°"
	}
	
	private func showTextView() {
		self.textView.showOrHide()
		self.saveButton.showOrHide()
		self.textView.cleanText()
	}
	
	private func hideTextView() {
		self.textView.hide()
		self.saveButton.hide()
		let text = self.textView.getTextAndClean()
		view.endEditing(true)
		self.weatherPresenter.updateNote(text)
	}
	
	private func showSettingsController() {
		let vc = storyboard?.instantiateViewController(identifier: SettingsController.identifier) as! SettingsController
		navigationController?.pushViewController(vc, animated: true)
	}
	
	private func showLocationAlert() {
		let alertController = UIAlertController (title: "Title", message: "Please allow location access in settings.", preferredStyle: .alert)

		let settingsAction = UIAlertAction(title: "Go to settings", style: .default) { _ in
			guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
				return
			}

			if UIApplication.shared.canOpenURL(settingsUrl) {
				UIApplication.shared.open(settingsUrl, completionHandler: nil)
			}
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
		alertController.addAction(settingsAction)
		alertController.addAction(cancelAction)

		present(alertController, animated: true, completion: nil)
	}
}

extension ViewController: WeatherPresenterDelegate {
	func newLocationWeather(_ locationWeather: LocationWeather?) {
		if let weather = locationWeather {
			self.setWeather(weather)
		}
	}
	
	func newNote(_ note: String?) {
		noteLabel.text = note
	}
	
	func locationManagerDenide() {
		showLocationAlert()
	}
}

