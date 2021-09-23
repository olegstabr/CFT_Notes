//
//  NoteRow.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

struct NoteRow: View {
	var note: Note
    var body: some View {
		VStack(alignment: .leading) {
			Text("\(note.title)")
				.fontWeight(.bold)
				.foregroundColor(.primary)
				.font(.title)
			if let desc = note.description {
				HStack {
					Text(desc)
					Spacer()
				}
				.font(.subheadline)
				.foregroundColor(.secondary)
			}
			Spacer()
		}
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var previews: some View {
		let note1 = Note(id: 1, title: "Test Note #1", description: "desc1", content: "It's a test note for this iOS App")
		let note2 = Note(id: 2, title: "Test Note #2", description: "desc2", content: "test test")
		Group {
			NoteRow(note: note1)
			NoteRow(note: note2)
		}
		.previewLayout(.fixed(width: 300, height: 70))
    }
}
