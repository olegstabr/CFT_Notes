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
	private(set) var lastIndex: Int?
	
	mutating func update(_ note: Note) {
		if let foundNoteIndex = notes.firstIndex(where: { $0.id == note.id }) {
			notes[foundNoteIndex] = note
		}
	}
	
	mutating func add() {
		var maxNoteId = getLastIndex()
		
		if maxNoteId == -1 {
			maxNoteId = 0
		} else {
			maxNoteId += 1
		}
		
		let note = Note(id: maxNoteId, title: "New note #\(maxNoteId)", description: "Empty description", content: "Enter note text here...")
		
		notes.append(note)
	}
	
	private func getLastIndex() -> Int {
		let maxNoteId = notes.map({ $0.id }).max()
		
		if let maxNoteId = maxNoteId {
			return maxNoteId
		} else {
			return -1
		}
	}
	
	mutating func remove(_ note: Note) {
		if let noteIndex = notes.firstIndex(where: { $0.id == note.id }) {
			notes.remove(at: noteIndex)
		}
	}
	
	mutating func remove(at index: Int) {
		notes.remove(at: index)
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

struct Note: Identifiable, Equatable, Codable, Hashable {
	var id: Int
	var title: String
	var description: String?
	var content: String
}
