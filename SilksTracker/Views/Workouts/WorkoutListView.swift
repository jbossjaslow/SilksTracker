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
	
	@State var printedWorkoutsText = ""
	
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
	
	@State private var showPrintDataSheet = false
	
	private var printDataButton: some View {
		Button("Print all data") {
			generateWorkoutsText()
			print(printedWorkoutsText)
			showPrintDataSheet = true
		}
		.foregroundStyle(Color.white)
		.padding()
		.frame(maxWidth: .infinity)
		.background(Color.blue)
		.clipShape(RoundedRectangle(cornerRadius: 8))
		.padding(.horizontal)
		.sheet(isPresented: $showPrintDataSheet) {
			TextEditor(text: $printedWorkoutsText)
		}
	}
	
	private func generateWorkoutsText() {
		printedWorkoutsText = ""
		
		for workout in workouts {
			printedWorkoutsText += "\n-- \(workout.date.formatted(date: .complete, time: .shortened))"
			for move in workout.moves.sorted() {
				printedWorkoutsText += "\n\(move.name)"
			}
			printedWorkoutsText += "\n"
		}
	}
}

//#Preview {
//    WorkoutListView()
//		.modelContainer(previewContainer)
//}
