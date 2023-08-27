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
		[
			Move.self,
			Workout.self
		]
	}
}
