//
//  MainAppView.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

struct MainAppView: View {
	@StateObject var noteVM: NoteViewModel
//	var notes = [Note(id: 1, title: "Test Note #1", description: "desc1", content: "It's a test note for this iOS App"),
//				 Note(id: 2, title: "Test Note #2", description: "desc2", content: "22222")]
    var body: some View {
		ZStack {
			NoteList(notes: noteVM.notes)
				.environmentObject(noteVM)
		}
		.onAppear {
			noteVM.load()
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let noteVM = NoteViewModel()
		MainAppView(noteVM: noteVM)
    }
}
