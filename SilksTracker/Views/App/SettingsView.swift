//
//  SettingsView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/1/23.
//

import SwiftUI
import Observation

struct SettingsView: View {
	@Environment(AppSettings.self) var settings
	
	var body: some View {
		@Bindable var settings = settings
		NavigationStack {
			Form {
//				Section {
				Toggle(isOn: $settings.showTimeWithDateInWorkoutList) {
					Text("Show time with date in workout list")
				}
				
				if SchemeChecker.isDebug {
					Toggle(isOn: $settings.showTimeWithDateInNewWorkout) {
						Text("Show time with date in new workout screen")
					}
				}
//				} header: {
//					Text("Workout Dates")
//				}
				
//				Section {
				Picker("Move List Ordering",
					   selection: $settings.moveListOrdering) {
					ForEach(MoveListOrderType.allCases, id: \.rawValue) { orderType in
						Text(orderType.rawValue)
							.tag(orderType)
					}
				}
					   .pickerStyle(.menu)
//				} header: {
//					Text("Move List Ordering")
//				}
				
				Section {
					NavigationLink("About") {
						AboutView()
					}
				} header: {
					EmptyView()
				}
			}
			.navigationTitle("Settings")
		}
	}
}
