//
//  WorkoutPreviewModel.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

import Foundation
import SwiftData

struct WorkoutPreviewModel {
	private init() {}
	
	static let workout = Workout(date: Date(),
								 moves: [
									Move(id: MoveNames.Arabesque.id,
										 name: MoveNames.Arabesque.name)
								 ])
	
	static let contents = [
		workout
	]
}

@MainActor
let previewContainer: ModelContainer = {
	do {
		let container = try ModelContainer(for: Workout.self,
										   ModelConfiguration(inMemory: true))
		for workout in WorkoutPreviewModel.contents {
			container.mainContext.insert(workout)
		}
		return container
	} catch {
		fatalError("Failed to create container")
	}
}()
