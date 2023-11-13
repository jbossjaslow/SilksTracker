//
//  GoalsTabView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import SwiftUI
import SwiftData

struct GoalsTabView: View {
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \Goal.dateCreated, order: .forward) var goals: [Goal]
	
	var body: some View {
		NavigationStack {
			VStack {
				List {
					ForEach(goals) { goal in
						NavigationLink {
							GoalDetailView(goalId: goal.id,
										   goalDetailViewMode: .editingExistingGoal)
						} label: {
							Text(goal.title)
						}
					}
					.onDelete { indexSet in
						indexSet.forEach { index in
							modelContext.delete(goals[index])
						}
						try? modelContext.save()
					}
				}
				
				NavigationLink {
					GoalDetailView(goalDetailViewMode: .addingNewGoal)
				} label: {
					Text("Add Goal")
						.standardButtonStyle
				}
				.padding(.horizontal)
			}
			.navigationTitle("My Goals")
		}
	}
}
