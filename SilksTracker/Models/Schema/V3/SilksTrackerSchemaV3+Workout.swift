//
//  SilksTrackerSchemaV3+workout.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//

import Foundation
import SwiftData
import SwiftUI
import UIKit

extension SilksTrackerSchemaV3 {
	@Model
	final class Workout {
		@Attribute(.unique) let id: UUID
		var date: Date
		var sticker: String
		var stickerRotation: Double
		var photos: [String] = []
		var notes: String = ""
		
		@Relationship(deleteRule: .nullify, inverse: \Move.workouts)
		private(set) var moves: [Move]
		
		@Relationship(deleteRule: .nullify, inverse: \Goal.associatedWorkout)
		private(set) var goals: [Goal]
		
		private var photoPrefixName: String {
			MediaFileNamePrefix.photos.rawValue + "workouts_\(id.uuidString)_"
		}
		
		init(date: Date,
			 moves: [Move] = [],
			 goals: [Goal] = [],
			 sticker: String = "",
			 stickerRotation: Double = 0,
			 photos: [String] = [],
			 notes: String = "") {
			self.id = UUID()
			self.date = date
			self.moves = moves
			self.goals = goals
			self.sticker = sticker
			self.stickerRotation = stickerRotation
			self.photos = photos
			self.notes = notes
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
		
		// MARK: - Photos
		@MainActor
		func savePhotos(_ images: [SilksImage]) {
			for image in images {
				guard !photos.contains(image.fileName) else {
					print("Photos array already contains \(image.fileName)")
					continue
				}
				
				let fullPath = photoPrefixName + photos.count.description + ".png"
				if let uiImage = image.image.uiImage,
				   uiImage.saveImage(fileName: fullPath) {
					// If image successfully saved, add path to photos array
					photos.append(fullPath)
				}
			}
		}
		
		func fetchPhotos() -> [SilksImage] {
			photos.compactMap {
				guard let image = UIImage.loadImageFromDiskWith(fileName: $0) else {
					return nil
				}
				
				return SilksImage(image: Image(uiImage: image),
								  fileName: $0)
			}
		}
		
		func deletePhotos(_ images: [SilksImage]) {
			for image in images {
				guard photos.contains(image.fileName) else {
					print("Photos array never contained this image")
					continue
				}
				
				photos.removeAll {
					$0 == image.fileName
				}
				UIImage.removeImage(fileName: image.fileName)
			}
		}
		
		// MARK: - Fetch descriptors
		static func fromId(_ id: UUID) -> FetchDescriptor<Workout> {
			FetchDescriptor(predicate: #Predicate { $0.id == id })
		}
	}
}

extension SilksTrackerSchemaV3.Workout: Comparable {
	static func < (lhs: SilksTrackerSchemaV3.Workout,
				   rhs: SilksTrackerSchemaV3.Workout) -> Bool {
		lhs.date < rhs.date
	}
}
