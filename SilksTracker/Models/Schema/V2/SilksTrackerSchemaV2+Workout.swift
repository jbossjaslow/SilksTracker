//
//  SilksTrackerSchemaV2+Workout.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import Foundation
import SwiftData

extension SilksTrackerSchemaV2 {
	@Model
	final class Workout {
		@Attribute(.unique) let id: UUID
		var date: Date
		var sticker: String
		var stickerRotation: Double
		
		@Relationship(deleteRule: .nullify, inverse: \Move.workouts)
		private(set) var moves: [Move]
		
		@Relationship(deleteRule: .nullify, inverse: \Goal.associatedWorkout)
		private(set) var goals: [Goal]
		
		init(date: Date,
			 moves: [Move] = [],
			 goals: [Goal] = [],
			 sticker: String = "",
			 stickerRotation: Double = 0) {
			self.id = UUID()
			self.date = date
			self.moves = moves
			self.goals = goals
			self.sticker = sticker
			self.stickerRotation = stickerRotation
		}
		
		func addMoves(_ newMoves: [Move]) {
			moves.append(contentsOf: newMoves)
		}
		
		func updateMoves(_ newMoves: [Move]) {
			moves = newMoves
		}
		
		func addGoals(_ newGoals: [Goal]) {
			goals.append(contentsOf: newGoals)
		}
		
		func updateGoals(_ newGoals: [Goal]) {
			goals = newGoals
		}
		
		// MARK: - Fetch descriptors
		static func fromId(_ id: UUID) -> FetchDescriptor<Workout> {
			FetchDescriptor(predicate: #Predicate { $0.id == id })
		}
	}
}

extension SilksTrackerSchemaV2.Workout: Comparable {
	static func < (lhs: SilksTrackerSchemaV2.Workout,
				   rhs: SilksTrackerSchemaV2.Workout) -> Bool {
		lhs.date < rhs.date
	}
}
