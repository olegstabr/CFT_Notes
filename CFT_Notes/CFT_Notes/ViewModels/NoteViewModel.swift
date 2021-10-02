//
//  NoteViewModel.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

class NoteViewModel: ObservableObject {
	@Published var noteModel: NoteModel = NoteModel(notes: [
		Note(id: 0, title: "ReadMe Note", description: "ReadMe", content: "1. Bottom toolbar - increase and decrease font size. \n2. Bold, italic, undeline - select text by tap and use standard Apple menu. \n3. Remove note - slide right in main menu with list of notes."),
		Note(id: 1, title: "Note With Image", description: "Note With Image", content: "Default note with image. Only THIS note has an image.", withImage: true)
	])
	
	var notes: [Note] {
		noteModel.notes
	}
	
	// MARK: - Intent(s)
	
	func update(note: Note) {
		noteModel.update(note)
	}
	
	func setContent(note: Note, content: String) {
		noteModel.setContent(note, content: content)
	}
	
	func add(withImage: Bool = false) {
		noteModel.add(withImage)
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
