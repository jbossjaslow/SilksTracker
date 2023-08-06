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
				Section {
					Toggle(isOn: $settings.showTimeWithDateInWorkoutList) {
						Text("Show time with date in workout list")
					}
					.onChange(of: settings.showTimeWithDateInWorkoutList) { oldValue, newValue in
						UserDefaults.standard.set(newValue,
												  forKey: UserDefaultsKey.showTimeWithDateInWorkoutList.rawValue)
					}
					
					Toggle(isOn: $settings.showTimeWithDateInNewWorkout) {
						Text("Show time with date in new workout screen")
					}
					.onChange(of: settings.showTimeWithDateInNewWorkout) { oldValue, newValue in
						UserDefaults.standard.set(newValue,
												  forKey: UserDefaultsKey.showTimeWithDateInNewWorkout.rawValue)
					}
				} header: {
					Text("Workout Dates")
				}
				
				Section {
					Picker("",
						   selection: $settings.moveListOrdering) {
						ForEach(OrderType.allCases, id: \.rawValue) { orderType in
							Text(orderType.rawValue)
								.tag(orderType)
						}
					}
						   .pickerStyle(.menu)
						   .onChange(of: settings.moveListOrdering) { oldValue, newValue in
							   UserDefaults.standard.set(newValue.rawValue,
														 forKey: UserDefaultsKey.moveListOrdering.rawValue)
						   }
				} header: {
					Text("Move List Ordering")
				}
			}
			.navigationTitle("Settings")
		}
	}
}
