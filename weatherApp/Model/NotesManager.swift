//
//  NotesManager.swift
//  weatherApp
//
//  Created by Aleksandr Maltsev on 26.07.2020.
//  Copyright © 2020 Aleksandr Maltsev. All rights reserved.
//

import Foundation

class NotesManager {
	
	private let noteKey = "NoteSecretKey"
	private let defaults = UserDefaults.standard
	
	func saveNote(_ note: String?) {
		guard let existingNote = note,
			!existingNote.isEmpty else { return }
		defaults.set(existingNote, forKey: noteKey)
	}
	
	func fetchNote() -> String? {
		let note = defaults.string(forKey: noteKey)
		guard let validNode = note else { return note }
		return validNode.isEmpty ? nil : validNode
	}
}
