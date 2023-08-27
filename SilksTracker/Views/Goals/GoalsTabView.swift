//
//  GoalsTabView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import SwiftUI

struct GoalsTabView: View {
	var body: some View {
		NavigationStack {
			VStack {
				GoalsListView { goal in
					Text(goal.text)
				}
				
				NavigationLink {
					Text("Add goal here")
				} label: {
					Text("Add Goal")
						.standardButtonStyle
				}
				.padding(.horizontal)
				
				Divider()
			}
			.navigationTitle("My Goals")
		}
	}
}
