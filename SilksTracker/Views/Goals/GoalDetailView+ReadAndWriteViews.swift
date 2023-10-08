//
//  GoalDetailView+EditOnlyViews.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 9/2/23.
//

import SwiftUI

extension GoalDetailView {
	// MARK: - Edit mode view only
	@ViewBuilder
	func readOnlyViews(goal: Goal) -> some View {
		Text(goal.title)
			.font(.title)
		
		Text(goal.subtitle)
			.font(.title2)
		
		Text("Goal created on \(goal.dateCreated.formatted())")
		
		if goal.hasBeenAchieved,
		   let dateAchieved = goal.dateAchieved {
			Text("Goal achieved on \(dateAchieved.formatted())")
		}
		
		if let workout = associatedWorkout {
			NavigationLink {
				WorkoutDetailView(workoutId: workout.id,
								  workoutDetailViewMode: .editingExistingWorkout)
			} label: {
				HStack {
					Text("Linked to workout on \(workout.date.formatted())")
					
					Spacer()
					
					Text(workout.sticker)
						.rotationEffect(Angle(degrees: workout.stickerRotation))
				}
			}
		}
		
		if !goal.associatedMoves.isEmpty {
			Text("Linked moves")
		}
		
		ForEach(goal.associatedMoves) { move in
//			MoveDetailRowView(move: move)
			// TODO: Make this a nav link again when this no longer causes memory leak
			HStack {
				Text(move.name)
				
				Spacer()
				
				Text(move.workouts.count.description)
			}
		}
	}
	
	// MARK: - Adding or editing
	@ViewBuilder
	func readAndWriteViews() -> some View {
		TextField("Goal title",
				  text: $title)
		.padding(.horizontal)
		
		TextField("Description",
				  text: $subtitle)
		.padding(.horizontal)
		
		Toggle("Goal has been achieved",
			   isOn: $goalAchieved.animation(.easeInOut))
		.padding(.horizontal)
		
		if goalAchieved {
			DatePicker("Date achieved",
					   selection: $dateAchieved,
					   displayedComponents: .date)
			.padding(.horizontal)
		}
		
		Toggle("Goal linked to workout",
			   isOn: $goalLinkedToWorkout.animation(.easeInOut))
		.onChange(of: goalLinkedToWorkout) { _, newValue in
			let workoutToAssign: Workout? = existingGoal?.associatedWorkout ?? workouts.first
			associatedWorkout = newValue ? workoutToAssign : nil
		}
		.padding(.horizontal)
		
		if goalLinkedToWorkout {
			workoutPicker
		}
		
		Toggle("Move-related goal",
			   isOn: $goalLinkedToMoves.animation(.easeInOut))
		.padding(.horizontal)
		
		if goalLinkedToMoves {
			MoveListView {
				modifyGoalMoveListRow(getMove(for: $0))
			}
		}
	}
	
	private var workoutPicker: some View {
		Picker("Associated workout",
			   selection: $associatedWorkout) {
			ForEach(workouts) { workout in
				Text(workout.date, style: .date)
					.tag(workout as Workout?)
			}
		}
			   .pickerStyle(.menu)
	}
	
	private func modifyGoalMoveListRow(_ move: Move) -> some View {
		HStack {
			Text(move.name)
			
			Spacer()
			
			Image(systemName: "checkmark.circle.fill")
				.opacity(selectedMoves.contains(move) ? 1 : 0)
		}
		.contentShape(Rectangle())
		.onTapGesture {
			withAnimation {
				onTapOfMove(move)
			}
		}
	}
}
