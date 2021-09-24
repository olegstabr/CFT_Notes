//
//  NoteList.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

struct NoteList: View {
	@State var notes: [Note] = []
	@EnvironmentObject var noteVM: NoteViewModel
	
    var body: some View {
		NavigationView {
			List {
				ForEach(noteVM.notes) { note in
					NavigationLink(destination: NoteDetail(content: note.content, note: note)) {
						NoteRow(note: note)
					}
				}
				.onDelete(perform: delete)
			}
			.navigationTitle("Notes")
		}
		.onAppear {
			notes = noteVM.notes
		}
	}
	
	func delete(at offsets: IndexSet) {
		notes = noteVM.notes
		notes.remove(atOffsets: offsets)
		offsets.forEach { (i) in
			noteVM.remove(at: i)
		}
	}
	
	func getNotes() {
		
	}
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
		NoteList(notes: [Note(id: 1, title: "Test Note #1", description: "desc1", content: "It's a test note for this iOS App"),
						 Note(id: 2, title: "Test Note #2", description: "desc2", content: "22222")])
    }
}
