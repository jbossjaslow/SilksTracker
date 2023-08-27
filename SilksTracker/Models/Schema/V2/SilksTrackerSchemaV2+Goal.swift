//
//  SilksTrackerSchemaV1+Goal.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import Foundation
import SwiftData

extension SilksTrackerSchemaV2 {
	@Model
	final class Goal {
		@Attribute(.unique) let id: UUID
		var text: String
		var hasBeenAchieved: Bool
		var dateCreated: Date
		
		@Relationship var workouts: [Workout] = []
		
		init(id: UUID = UUID(),
			 text: String,
			 hasBeenAchieved: Bool = false,
			 dateCreated: Date = Date()) {
			self.id = id
			self.text = text
			self.hasBeenAchieved = hasBeenAchieved
			self.dateCreated = dateCreated
		}
	}
}

// TODO: Add goal creation screen
// TODO: link up goals to workouts
// TODO: allow for goals to be achieved

extension SilksTrackerSchemaV2.Goal: Identifiable {}
