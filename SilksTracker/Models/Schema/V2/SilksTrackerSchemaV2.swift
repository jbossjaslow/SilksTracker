//
//  SilksTrackerSchemaV2.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import Foundation
import SwiftData

enum SilksTrackerSchemaV2: VersionedSchema {
	static var versionIdentifier: Schema.Version = .init(2, 0, 0)
	
	static var models: [any PersistentModel.Type] {
		[
			Move.self,
			Workout.self,
			Goal.self
		]
	}
}
