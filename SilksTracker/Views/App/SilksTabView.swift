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
			VStack {
				FundamenatalsListView()
				
				Divider()
			}
			.tabItem {
				Text("Fundamentals")
				
				Image(systemName: "figure.climbing")
			}
			
			VStack {
				WorkoutListView()
				
				Divider()
			}
			.tabItem {
				Text("Workouts")
				
				Image(systemName: "list.bullet")
			}
			
			if SchemeChecker.isDebug {
				VStack {
					GoalsTabView()
					
					Divider()
				}
				.tabItem {
					Text("Goals")
					
					Image(systemName: "text.badge.checkmark")
				}
			}
			
			VStack {
				SettingsView()
				
				Divider()
			}
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
