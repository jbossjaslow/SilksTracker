//
//  SilksTrackerSchemaV3.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//

import Foundation
import SwiftData

enum SilksTrackerSchemaV3: VersionedSchema {
	static var versionIdentifier: Schema.Version = .init(3, 0, 0)
	
	static var models: [any PersistentModel.Type] {
		[
			Move.self,
			Workout.self,
			Goal.self
		]
	}
}
