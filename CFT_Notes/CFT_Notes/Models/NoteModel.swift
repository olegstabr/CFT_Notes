//
//  NoteModel.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import Foundation
import SwiftUI
import CoreData

struct NoteModel {
	private(set) var notes: [Note]
	
	mutating func update(_ note: Note) {
		if let foundNoteIndex = notes.firstIndex(where: { $0.id == note.id }) {
			notes[foundNoteIndex] = note
		}
	}
	
	mutating func add() {
		let note = Note(id: notes.count, title: "New note #\(notes.count)", description: "Empty description", content: "Enter note text here...")
		notes.append(note)
	}
	
	mutating func remove(_ note: Note) {
		if let noteIndex = notes.firstIndex(where: { $0.id == note.id }) {
			notes.remove(at: noteIndex)
		}
	}
	
	mutating func load() {
		let fm = FileManager.default
		let filename = "notes_data"
		let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
		var notes: [Note] = []
		if let url = urls.first {
			var fileURL = url.appendingPathComponent(filename)
			fileURL = fileURL.appendingPathExtension("json")
			do {
				let data = try Data(contentsOf: fileURL)
				let decoder = JSONDecoder()
				notes = try decoder.decode([Note].self, from: data)
				self.notes = notes
			} catch {
//				fatalError("Couldn't parse \(filename) as \(Note.self):\n\(error)")
			}
		}
	}
	
	mutating func save() -> Bool {
		// Transform array into data and save it into file
//		do {
//			let data = try JSONSerialization.data(withJSONObject: notes, options: [])
//			try data.write(to: URL(fileURLWithPath: "notes_data.json"), options: [])
//		} catch {
//			print(error)
//		}

		do {
			let fm = FileManager.default
			let filename = "notes_data"
			let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
			let encoder = JSONEncoder()
			encoder.outputFormatting = .prettyPrinted

			if let url = urls.first {
				var fileURL = url.appendingPathComponent(filename)
				fileURL = fileURL.appendingPathExtension("json")
//				let data = try JSONSerialization.data(withJSONObject: notes, options: [.prettyPrinted])
				let data = try encoder.encode(notes)
				try data.write(to: fileURL, options: [.atomicWrite])
				return true
			}
		} catch {
			print(error)
			return false
		}
		
		return false
	}
}

struct Note: Identifiable, Equatable, Codable {
	var id: Int
	var title: String
	var description: String?
	var content: String
}
