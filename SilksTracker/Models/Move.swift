//
//  Moves.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/15/23.
//

import Foundation
import SwiftData

@Model
final class Move {
	@Attribute(.unique) let id: String
	let name: String
	@Relationship var workouts: [Workout]
	
	init(id: String,
		 name: String) {
		self.id = id
		self.name = name
	}
	
	convenience init(moveName: MoveName) {
		self.init(id: moveName.id,
				  name: moveName.name)
	}
}

extension Move: Comparable, Equatable {
	static func < (lhs: Move, rhs: Move) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: Move, rhs: Move) -> Bool {
		lhs.id == rhs.id
	}
}
