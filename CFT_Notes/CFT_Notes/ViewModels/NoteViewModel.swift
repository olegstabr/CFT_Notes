//
//  NoteViewModel.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

class NoteViewModel: ObservableObject {
	@Published var noteModel: NoteModel = NoteModel(notes: [])
	
	var notes: [Note] {
		noteModel.notes
	}
	
	// MARK: - Intent(s)
	
	func update(note: Note) {
		noteModel.update(note)
	}
	
	func add() {
		noteModel.add()
	}
	
	func remove(_ note: Note) {
		noteModel.remove(note)
	}
	
	func remove(at index: Int) {
		noteModel.remove(at: index)
		save()
	}
	
	func load() {
		noteModel.load()
	}
	
	func save() {
		let _ = noteModel.save()
	}
}
