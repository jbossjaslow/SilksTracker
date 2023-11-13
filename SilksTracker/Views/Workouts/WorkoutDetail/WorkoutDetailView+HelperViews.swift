//
//  WorkoutDetailView+HelperViews.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/12/23.
//

import SwiftUI

extension WorkoutDetailView {
	@ViewBuilder
	var addViewContent: some View {
		photosView
		
		moveListView
		
		saveButton
	}
	
	@ViewBuilder
	func editViewContent(_ editMode: Binding<EditMode>,
								 _ existingWorkout: Workout) -> some View {
		switch editMode.wrappedValue {
			case .active:
				photosView
				
				moveListView
				
				saveButton
			case .inactive:
				if !selectedImages.isEmpty {
					photosView
				}
				
				viewExistingWorkoutView(workout: existingWorkout)
			default:
				EmptyView()
		}
	}
	
	@ViewBuilder
	func viewExistingWorkoutView(workout: Workout) -> some View {
		List {
			Section {
				ForEach(workout.moves.sorted()) { move in
					MoveDetailRowView(move: move)
				}
			} header: {
				Text("Exercises")
			}
		}
	}
	
	var moveListView: some View {
		MoveListView {
			modifyWorkoutListRow(Move(moveName: $0))
		}
	}
	
	func modifyWorkoutListRow(_ move: Move) -> some View {
		HStack {
			Text(move.name)
			
			Spacer()
			
			if let move = moves.first(where: { $0.name == move.name }) {
				Text(move.workouts.count.description)
			}
			
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
	
	var saveButton: some View {
		Button {
			Task {
				await MainActor.run {
					saveWorkout()
				}
			}
		} label: {
			Text(saveButtonText)
				.standardButtonStyle
		}
		.padding(.horizontal)
	}
	
	var photosView: some View {
		PhotosDisplayView(selectedImages: $selectedImages,
						  isActivelyEditing: isActivelyEditing,
						  deleteImage: deleteImage)
			.frame(height: 120)
			.padding(.horizontal)
	}
}
