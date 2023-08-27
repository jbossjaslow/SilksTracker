//
//  SilksTrackerSchemaV1.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import Foundation
import SwiftData

enum SilksTrackerSchemaV1: VersionedSchema {
	static var versionIdentifier: Schema.Version = .init(1, 0, 0)
	
	static var models: [any PersistentModel.Type] {
		[Move.self, Workout.self]
	}
	
	@Model
	final class Move {
		@Attribute(.unique) let id: String
		let name: String
		@Relationship var workouts: [Workout] = []
		
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

extension Move: Comparable, Equatable {
	static func < (lhs: Move, rhs: Move) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: Move, rhs: Move) -> Bool {
		lhs.id == rhs.id
	}
}

extension Workout: Comparable {
	static func < (lhs: Workout, rhs: Workout) -> Bool {
		lhs.date < rhs.date
	}
}
