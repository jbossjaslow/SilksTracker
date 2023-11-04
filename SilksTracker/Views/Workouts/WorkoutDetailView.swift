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
	
	@Environment(\.modelContext) private var modelContext
	@Environment(\.editMode) private var editMode
	@Environment(\.dismiss) private var dismiss
	
	@State var date = Date()
	@State var selectedMoves: Set<Move> = Set()
	@State var showingBatchInput = false
	
	@State var selectedSticker = ""
	@State var stickerRotation: Angle = .zero
	
	@State var selectedImages: [SilksImage] = []
	@State var photosToDelete: [SilksImage] = []
	
	private let workoutDetailViewMode: WorkoutDetailViewMode
	
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
	
	// MARK: - Helper views
	@ViewBuilder
	private var addViewContent: some View {
		photosView
		
		moveListView
		
		saveButton
	}
	
	@ViewBuilder
	private func editViewContent(_ editMode: Binding<EditMode>,
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
		
		Divider()
	}
	
	@ViewBuilder
	private func viewExistingWorkoutView(workout: Workout) -> some View {
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
	
	private var moveListView: some View {
		MoveListView {
			modifyWorkoutListRow(Move(moveName: $0))
		}
	}
	
	private func modifyWorkoutListRow(_ move: Move) -> some View {
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
	
	@ViewBuilder
	var photosView: some View {
		if isActivelyEditing {
			ImageSelectionView(selectedImages: $selectedImages,
							   onDelete: deleteImage)
			.frame(height: 120)
			.padding(.horizontal)
		} else {
			ScrollView(.vertical) {
				LazyVGrid(columns: Array(repeating: GridItem(),
										 count: 4),
						  spacing: 10) {
					ForEach(selectedImages, id: \.fileName) { selectedImage in
						PreviewableImageView(image: selectedImage.image)
							.containerRelativeFrame(.horizontal,
													count: 4,
													span: 1,
													spacing: 10)
					}
				}
			}
			.frame(height: 120)
			.padding(.horizontal)
		}
	}
	
	// MARK: - Logic functions
	private func onAppear(existingWorkout: Workout) {
		selectedMoves = Set(existingWorkout.moves)
		date = existingWorkout.date
		selectedSticker = existingWorkout.sticker
		stickerRotation = Angle(degrees: existingWorkout.stickerRotation)
		selectedImages = existingWorkout.fetchPhotos()
	}
	
	private func onTapOfMove(_ move: Move) {
		if selectedMoves.contains(move) {
			selectedMoves.remove(move)
		} else {
			selectedMoves.insert(move)
		}
	}
	
	@MainActor
	private func saveWorkout() {
		switch workoutDetailViewMode {
			case .addingNewWorkout:
				saveNewWorkout()
			case .editingExistingWorkout:
				saveExistingWorkout()
		}
		
		try? modelContext.save()
	}
	
	@MainActor
	private func saveNewWorkout() {
		let newWorkout = Workout(date: date,
								 sticker: selectedSticker,
								 stickerRotation: stickerRotation.degrees)
		modelContext.insert(newWorkout)
		newWorkout.addMoves(Array(selectedMoves))
		newWorkout.savePhotos(selectedImages)
		
		dismiss()
	}
	
	@MainActor
	private func saveExistingWorkout() {
		guard let existingWorkout else {
			print("Workout doesn't exist")
			return
		}
		
		existingWorkout.updateMoves(Array(selectedMoves))
		existingWorkout.date = date
		existingWorkout.sticker = selectedSticker
		existingWorkout.stickerRotation = stickerRotation.degrees
//		existingWorkout?.photos.removeAll()
		if !photosToDelete.isEmpty {
			existingWorkout.deletePhotos(photosToDelete)
		}
		existingWorkout.savePhotos(selectedImages)
		
		withAnimation(.easeInOut) {
			editMode?.wrappedValue = .inactive
		}
	}
	
	private func deleteImage(_ photoToDelete: SilksImage) {
		guard workoutDetailViewMode == .editingExistingWorkout else {
			return
		}
		
		photosToDelete.append(photoToDelete)
	}
}
