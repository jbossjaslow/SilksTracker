//
//  SilksTrackerSchemaV3+Move.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//

import Foundation
import SwiftData

extension SilksTrackerSchemaV3 {
	@Model
	final class Move {
		@Attribute(.unique) let id: String
		let name: String
		@Relationship var workouts: [Workout] = []
		@Relationship var goals: [Goal] = []
		var notes: String = ""
		
		init(id: String,
			 name: String,
			 notes: String = "") {
			self.id = id
			self.name = name
			self.notes = notes
		}
		
		convenience init(moveName: MoveName,
						 notes: String = "") {
			self.init(id: moveName.id,
					  name: moveName.name,
					  notes: notes)
		}
	}
}

extension SilksTrackerSchemaV3.Move: Comparable, Equatable, Hashable {
	static func < (lhs: SilksTrackerSchemaV3.Move,
				   rhs: SilksTrackerSchemaV3.Move) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: SilksTrackerSchemaV3.Move,
					rhs: SilksTrackerSchemaV3.Move) -> Bool {
		lhs.id == rhs.id
	}
}
