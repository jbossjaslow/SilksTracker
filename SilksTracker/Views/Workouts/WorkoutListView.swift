//
//  WorkoutListView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

import SwiftData
import SwiftUI

struct WorkoutListView: View {
	@Environment(AppSettings.self) var settings
	@Environment(\.modelContext) private var modelContext
	@Query(sort: \Workout.date, order: .forward) var workouts: [Workout]
	
	var zippedWorkouts: [(Range<Array<Workout>.Index>.Element, Workout)] {
		Array(zip(workouts.indices, workouts))
	}
	
    var body: some View {
		NavigationStack {
			ScrollViewReader { proxy in
				content(proxy: proxy)
			}
		}
    }
	
	private func content(proxy: ScrollViewProxy) -> some View {
		VStack {
			List {
				ForEach(zippedWorkouts, id: \.0) { index, workout in
					navlinkView(workout: workout)
						.id(index)
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
				.onDisappear {
					proxy.scrollTo(workouts.endIndex,
								   anchor: .center)
				}
			} label: {
				Text("Add Workout")
					.standardButtonStyle
			}
			.padding(.horizontal)
			
			if SchemeChecker.isDebug {
				HStack(spacing: 4) {
					PrintAllDataView()
					
					BatchWorkoutInputView()
				}
				.padding(.horizontal)
			}
			
			Divider()
		}
		.navigationTitle("\(workouts.count) Workout\(workouts.count == 1 ? "" : "s")")
		.navigationDestination(for: Workout.self) { workout in
			WorkoutDetailView(workoutId: workout.id,
							  workoutDetailViewMode: .editingExistingWorkout)
			.onDisappear {
				proxy.scrollTo(workouts.firstIndex(of: workout) ?? workouts.endIndex,
							   anchor: .center)
			}
		}
	}
	
	private func navlinkView(workout: Workout) -> some View {
		NavigationLink(value: workout) {
			HStack {
				Text(workout.date.formatted(date: .numeric,
											time: settings.showTimeWithDateInWorkoutList ? .shortened : .omitted))
				
				Spacer()
				
				Text(workout.sticker)
					.rotationEffect(Angle(degrees: workout.stickerRotation))
			}
		}
	}
}
