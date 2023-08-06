//
//  Workout.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

import Foundation
import SwiftData

@Model
final class Workout {
	@Attribute(.unique) let id: UUID
	var date: Date
	@Relationship(.nullify, inverse: \Move.workouts)
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

extension Workout: Comparable {
	static func < (lhs: Workout, rhs: Workout) -> Bool {
		lhs.date < rhs.date
	}
}
