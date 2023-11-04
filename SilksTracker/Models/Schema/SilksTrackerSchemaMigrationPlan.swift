//
//  SilksTrackerSchemaMigrationPlan.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//

import SwiftData

// MARK: - Unused
enum SilksTrackerSchemaMigrationPlan: SchemaMigrationPlan {
	static var schemas: [any VersionedSchema.Type] {
		[
			SilksTrackerSchemaV2.self,
			SilksTrackerSchemaV3.self
		]
	}
	
	static var stages: [MigrationStage] {
		[]
	}
}
