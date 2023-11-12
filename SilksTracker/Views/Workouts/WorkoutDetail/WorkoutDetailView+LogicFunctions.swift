//
//  WorkoutDetailView+LogicFunctions.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/12/23.
//

import SwiftUI

extension WorkoutDetailView {
	func onAppear(existingWorkout: Workout) {
		selectedMoves = Set(existingWorkout.moves)
		date = existingWorkout.date
		selectedSticker = existingWorkout.sticker
		stickerRotation = Angle(degrees: existingWorkout.stickerRotation)
		selectedImages = existingWorkout.fetchPhotos()
	}
	
	func onTapOfMove(_ move: Move) {
		if selectedMoves.contains(move) {
			selectedMoves.remove(move)
		} else {
			selectedMoves.insert(move)
		}
	}
	
	@MainActor
	func saveWorkout() {
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
	
	func deleteImage(_ photoToDelete: SilksImage) {
		guard workoutDetailViewMode == .editingExistingWorkout else {
			return
		}
		
		photosToDelete.append(photoToDelete)
	}

}
