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
	@Query(sort: \Workout.date, order: .forward)
	var workouts: [Workout]
	
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
				
				printDataButton
				
				Divider()
			}
			.navigationTitle("Workouts")
		}
    }
	
	private var printDataButton: some View {
		Button("Print all data") {
			for workout in workouts {
				print(workout.date.formatted(date: .complete,
											 time: .shortened))
				for move in workout.moves.sorted() {
					print("- \(move.name)")
				}
				print("")
			}
		}
		.foregroundStyle(Color.white)
		.padding()
		.frame(maxWidth: .infinity)
		.background(Color.blue)
		.clipShape(RoundedRectangle(cornerRadius: 8))
		.padding(.horizontal)
	}
}

//#Preview {
//    WorkoutListView()
//		.modelContainer(previewContainer)
//}
