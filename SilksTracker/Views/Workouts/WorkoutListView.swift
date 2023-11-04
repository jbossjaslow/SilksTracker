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
						navlinkView(workout: workout)
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
						.standardButtonStyle
				}
				.padding(.horizontal)
				
				HStack(spacing: 4) {
					PrintAllDataView()
					
					BatchWorkoutInputView()
				}
				.padding(.horizontal)
				
				Divider()
			}
			.navigationTitle("\(workouts.count) Workout\(workouts.count == 1 ? "" : "s")")
			.navigationDestination(for: Workout.self) { workout in
				WorkoutDetailView(workoutId: workout.id,
								  workoutDetailViewMode: .editingExistingWorkout)
			}
		}
    }
	
	private func navlinkView(workout: Workout) -> some View {
		NavigationLink(value: workout) {
			HStack {
				Text(workout.date.formatted(.dateTime))
				
				Spacer()
				
				Text(workout.sticker)
					.rotationEffect(Angle(degrees: workout.stickerRotation))
			}
		}
	}
}
