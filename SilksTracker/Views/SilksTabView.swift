//
//  SilksTabView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

import SwiftUI

struct SilksTabView: View {
	var body: some View {
		TabView {
			FundamenatalsListView()
				.tabItem {
					Text("Fundamentals")
					
					Image(systemName: "figure.climbing")
				}
			
			WorkoutListView()
				.tabItem {
					Text("Workouts")
					
					Image(systemName: "list.bullet")
				}
			
			GoalsTabView()
				.tabItem {
					Text("Goals")
					
					Image(systemName: "text.badge.checkmark")
				}
			
			SettingsView()
				.tabItem {
					Text("Settings")
					
					Image(systemName: "gear")
				}
		}
	}
}

//#Preview {
//	SilksTabView()
//		.modelContainer(previewContainer)
//}
