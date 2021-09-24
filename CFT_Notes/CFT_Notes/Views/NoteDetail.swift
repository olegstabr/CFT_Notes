//
//  NoteDetail.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

struct NoteDetail: View {
	@State var content: String
	@EnvironmentObject var noteVM: NoteViewModel
	var note: Note
    var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				Text(note.title)
					.font(.title)
					.fontWeight(.bold)
				TextEditor(text: $content)
					.onTapGesture {	}
			}
			.padding(.horizontal)
			.foregroundColor(.primary)
		}
		.onTapGesture {
			hideKeyboardAndSave()
		}
    }
	
	private func hideKeyboardAndSave() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
		save()
	}
	
	private func save() {
		noteVM.setContent(note: note, content: content)
		noteVM.save()
	}
}

struct NoteDetail_Previews: PreviewProvider {
    static var previews: some View {
		NoteDetail(content: "", note: Note(id: 1, title: "TTTTT1", description: "dsadsadsd", content: "content CONNSADFNSANDFA"))
    }
}
