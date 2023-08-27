//
//  WorkoutListView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

import SwiftData
import SwiftUI

struct WorkoutListView: View {
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \Workout.date, order: .forward) var workouts: [Workout]
	
    var body: some View {
		NavigationStack {
			VStack {
				List {
					ForEach(workouts) { workout in
						WorkoutDetailRowView(workout: workout)
					}
					.onDelete { indexSet in
						indexSet.forEach { index in
							modelContext.delete(workouts[index])
						}
						try? modelContext.save()
					}
				}
				
				NavigationLink {
					WorkoutDetailView(workoutId: nil,
									  workoutDetailViewMode: .addingNewWorkout)
				} label: {
					Text("Add Workout")
						.foregroundStyle(Color.white)
						.padding()
						.frame(maxWidth: .infinity)
						.background(Color.blue)
						.clipShape(RoundedRectangle(cornerRadius: 8))
				}
				.padding(.horizontal)
				
				HStack(spacing: 4) {
					PrintAllDataView()
					
					BatchWorkoutInputView()
				}
				.padding(.horizontal)
				
				Divider()
			}
			.navigationTitle("Workouts")
		}
    }
}
