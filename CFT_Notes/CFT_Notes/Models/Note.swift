//
//  Note.swift
//  CFT_Notes
//
//  Created by Олег Стабровский on 23.09.2021.
//

import Foundation

struct Note: Identifiable {
	var id: Int
	var title: String
	var description: String?
	var content: String
}
