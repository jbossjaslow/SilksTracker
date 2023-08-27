//
//  SilksTrackerApp.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/15/23.
//

import SwiftUI
import SwiftData

@main
struct SilksTrackerApp: App {
	@State var settings = AppSettings()
	
    var body: some Scene {
        WindowGroup {
			SilksTabView()
				.modelContainer(for: SilksTrackerSchemaV2.models)
				.environment(settings)
        }
    }
}
