//
//  MoveGroup.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

struct MoveGroup: Identifiable {
	let id: Int
	let sectionTitle: String
	let moves: [MoveName]
	
	init(id: Int,
		 sectionTitle: String = "",
		 moves: [MoveName]) {
		self.id = id
		self.sectionTitle = sectionTitle
		self.moves = moves
	}
}
