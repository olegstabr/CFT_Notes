//
//  NoteDetail.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

struct NoteDetail: View {
	@State var content: String
	var note: Note
    var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				Text(note.title)
					.font(.title)
					.fontWeight(.bold)
				TextEditor(text: $content)
			}
			.padding(.horizontal)
			.foregroundColor(.primary)
		}
    }
}

struct NoteDetail_Previews: PreviewProvider {
    static var previews: some View {
		NoteDetail(content: "", note: Note(id: 1, title: "TTTTT1", description: "dsadsadsd", content: "content CONNSADFNSANDFA"))
    }
}
