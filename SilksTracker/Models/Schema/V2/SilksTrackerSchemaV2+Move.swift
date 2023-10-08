//
//  SilksTrackerSchemaV2+Move.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import SwiftData

extension SilksTrackerSchemaV2 {
	@Model
	final class Move {
		@Attribute(.unique) let id: String
		let name: String
		@Relationship var workouts: [Workout] = []
		@Relationship var goals: [Goal] = []
		
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
}

extension SilksTrackerSchemaV2.Move: Comparable, Equatable {
	static func < (lhs: SilksTrackerSchemaV2.Move,
				   rhs: SilksTrackerSchemaV2.Move) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: SilksTrackerSchemaV2.Move,
					rhs: SilksTrackerSchemaV2.Move) -> Bool {
		lhs.id == rhs.id
	}
}
