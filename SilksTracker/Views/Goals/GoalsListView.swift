//
//  GoalsListView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import SwiftData
import SwiftUI

struct GoalsListView<Content: View>: View {
	@Environment(AppSettings.self) var settings
	@Query var goals: [Goal]
	
	let listRow: (Goal) -> Content
	
	var body: some View {
		List {
			ForEach(goals) { goal in
				listRow(goal)
			}
		}
	}
	
//	@ViewBuilder
//	private var alphabeticalListContent: some View {
//		ForEach()
//	}
}
