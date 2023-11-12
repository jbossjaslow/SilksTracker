//
//  WorkoutDetailView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/8/23.
//

import SwiftData
import SwiftUI

struct WorkoutDetailView: View {
	// MARK: - Properties
	@Query var workouts: [Workout]
	@Query var moves: [Move]
	
	@Environment(\.modelContext) var modelContext
	@Environment(\.editMode) var editMode
	@Environment(\.dismiss) var dismiss
	
	@State var date = Date()
	@State var selectedMoves: Set<Move> = Set()
	@State var showingBatchInput = false
	
	@State var selectedSticker = ""
	@State var stickerRotation: Angle = .zero
	
	@State var selectedImages: [SilksImage] = []
	@State var photosToDelete: [SilksImage] = []
	
	let workoutDetailViewMode: WorkoutDetailViewMode
	
	init(workoutId: UUID? = nil,
		 workoutDetailViewMode: WorkoutDetailViewMode) {
		if let id = workoutId {
			_workouts = Query(Workout.fromId(id))
		}
		self.workoutDetailViewMode = workoutDetailViewMode
	}
	
	var existingWorkout: Workout? {
		guard workoutDetailViewMode == .editingExistingWorkout else {
			return nil
		}
		return workouts.first
	}
	
	var isActivelyEditing: Bool {
		workoutDetailViewMode == .addingNewWorkout ||
		(workoutDetailViewMode == .editingExistingWorkout && editMode?.wrappedValue == .active)
	}
	
	var saveButtonText: String {
		switch workoutDetailViewMode {
			case .addingNewWorkout:
				"Save New Workout"
			case .editingExistingWorkout:
				"Save Workout"
		}
	}
	
	var navTitle: String {
		switch workoutDetailViewMode {
			case .addingNewWorkout:
				"Add New Workout"
			case .editingExistingWorkout:
				existingWorkout?.date.formatted(.dateTime) ?? "Unknown workout"
		}
	}
	
	// MARK: - Body
	var body: some View {
		VStack {
			viewsOnlyForEditing
				.padding(.horizontal, 10)
			
			switch workoutDetailViewMode {
				case .addingNewWorkout:
					addViewContent
				case .editingExistingWorkout:
					if let editMode = editMode,
					   let existingWorkout = existingWorkout {
						editViewContent(editMode,
										existingWorkout)
						.onAppear {
							onAppear(existingWorkout: existingWorkout)
						}
					} else {
						Text("Unable to locate data")
					}
			}
		}
		.navigationTitle(navTitle)
		.toolbar {
			if workoutDetailViewMode == .editingExistingWorkout {
				EditButton()
			}
		}
		.sheet(isPresented: $showingBatchInput) {
			BatchMoveInputView(selectedMoves: $selectedMoves)
		}
	}
}
