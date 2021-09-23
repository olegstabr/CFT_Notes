//
//  MainAppView.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import SwiftUI

struct MainAppView: View {
    var body: some View {
		VStack {
			HStack {
				Spacer()
				Button {
					
				} label: {
					Image(systemName: "note.text.badge.plus")
						.font(.largeTitle)
				}
				.padding(.horizontal)
			}
			Spacer()
			Text("dsds")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
