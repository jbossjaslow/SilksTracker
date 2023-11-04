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
	@State var globalProperties = GlobalProperties()
	
    var body: some Scene {
        WindowGroup {
			ZStack {
				SilksTabView()
					.modelContainer(for: SilksTrackerSchemaV3.models)
					.environment(settings)
					.disabled(globalProperties.presentingImage != nil)
				
				if globalProperties.presentingImage != nil {
					ImagePreView()
				}
			}
			.environment(globalProperties)
        }
    }
}
