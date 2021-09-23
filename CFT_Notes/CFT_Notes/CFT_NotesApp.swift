//
//  CFT_NotesApp.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

@main
struct CFT_NotesApp: App {
    var body: some Scene {
        WindowGroup {
			let noteVM = NoteViewModel()
            MainAppView(noteVM: noteVM)
        }
    }
}
