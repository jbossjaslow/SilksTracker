//
//  SilksTrackerSchemaV1+Workout.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import Foundation
import SwiftData

extension SilksTrackerSchemaV1 {
	@Model
	final class Workout {
		@Attribute(.unique) let id: UUID
		var date: Date
		@Relationship(deleteRule: .nullify, inverse: \Move.workouts)
		private(set) var moves: [Move]
		var sticker: String
		var stickerRotation: Double
		
		init(date: Date,
			 moves: [Move] = [],
			 sticker: String = "",
			 stickerRotation: Double = 0) {
			self.id = UUID()
			self.date = date
			self.moves = moves
			self.sticker = sticker
			self.stickerRotation = stickerRotation
		}
		
		func addMoves(_ newMoves: [Move]) {
			moves.append(contentsOf: newMoves)
		}
		
		func updateMoves(_ newMoves: [Move]) {
			moves = newMoves
		}
		
		// MARK: - Fetch descriptors
		static func fromId(_ id: UUID) -> FetchDescriptor<Workout> {
			FetchDescriptor(predicate: #Predicate { $0.id == id })
		}
	}
}

extension SilksTrackerSchemaV1.Workout: Comparable {
	static func < (lhs: SilksTrackerSchemaV1.Workout,
				   rhs: SilksTrackerSchemaV1.Workout) -> Bool {
		lhs.date < rhs.date
	}
}
