//
//  SilksTrackerSchemaV3+Goal.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//

import Foundation
import SwiftData

extension SilksTrackerSchemaV3 {
	@Model
	final class Goal {
		@Attribute(.unique) let id: UUID
		var title: String
		var subtitle: String
		var dateCreated: Date
		var dateAchieved: Date?
		
		@Relationship(deleteRule: .nullify, inverse: \Move.goals)
		var associatedMoves: [Move]
		
		@Relationship var associatedWorkout: Workout?
		
		var hasBeenAchieved: Bool {
			dateAchieved != nil
		}
		var linkedToWorkout: Bool {
			associatedWorkout != nil
		}
		
		init(id: UUID = UUID(),
			 title: String,
			 subtitle: String = "",
			 dateCreated: Date = Date(),
			 dateAchieved: Date? = nil,
			 associatedMoves: [Move] = [],
			 associatedWorkout: Workout? = nil) {
			self.id = id
			self.title = title
			self.subtitle = subtitle
			self.dateCreated = dateCreated
			self.dateAchieved = dateAchieved
			self.associatedMoves = associatedMoves
			self.associatedWorkout = associatedWorkout
		}
		
		// MARK: - Helper functions
		func addMoves(_ newMoves: [Move]) {
			associatedMoves.append(contentsOf: newMoves)
		}
		
		func updateMoves(_ newMoves: [Move]) {
			associatedMoves = newMoves
		}
		
		func updateWorkout(_ newWorkout: Workout?) {
			associatedWorkout = newWorkout
		}
		
		// MARK: - Fetch descriptors
		static func fromId(_ id: UUID) -> FetchDescriptor<Goal> {
			FetchDescriptor(predicate: #Predicate { $0.id == id })
		}
	}
}

// TODO: Add goal creation screen
// TODO: link up goals to workouts
// TODO: allow for goals to be achieved

extension SilksTrackerSchemaV3.Goal: Identifiable {}
