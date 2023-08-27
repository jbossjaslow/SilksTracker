//
//  BatchWorkoutInputView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import SwiftUI
import SwiftData

struct BatchWorkoutInputView: View {
	@Environment(\.modelContext) private var modelContext
	@Query var moves: [Move]
	
	@State private var sheetPresented = false
	@State private var batchWorkoutsText = ""
	@FocusState var keyboardFocused: Bool
	
	var body: some View {
		Button("Add batch workouts") {
			sheetPresented = true
		}
		.foregroundStyle(Color.white)
		.padding()
		.frame(maxWidth: .infinity)
		.background(Color.blue)
		.clipShape(RoundedRectangle(cornerRadius: 8))
		.sheet(isPresented: $sheetPresented) {
			sheetView
		}
	}
	
	private var sheetView: some View {
		VStack {
			TextEditor(text: $batchWorkoutsText)
				.focused($keyboardFocused)
			
			HStack {
				Button("Paste") {
					if let copiedText = UIPasteboard.general.string {
						batchWorkoutsText = copiedText
					} else {
						print("Nothing on pasteboard")
					}
				}
				.foregroundStyle(Color.white)
				.padding()
				.frame(maxWidth: .infinity)
				.background(Color.blue)
				.clipShape(RoundedRectangle(cornerRadius: 8))
				
				Button("Save") {
					addBatchWorkouts()
					print("Finished adding batch workouts!")
					sheetPresented = false
				}
				.foregroundStyle(Color.white)
				.padding()
				.frame(maxWidth: .infinity)
				.background(Color.blue)
				.clipShape(RoundedRectangle(cornerRadius: 8))
			}
		}
		.padding()
	}
	
	private func addBatchWorkouts() {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE, MM d, yyyy, h:mm aa"
		let workoutsArray = batchWorkoutsText.split(separator: "\n\n")
		for workoutString in workoutsArray {
			let exercises = workoutString.split(separator: "\n")
			let date = formatter.date(from: String(exercises.first ?? ""))
			var movesArray: [Move] = []
			for i in 1..<exercises.count {
				if let move = getMove(moveName: String(exercises[i])) {
					movesArray.append(move)
				}
			}
			
			if let date = date {
				let newWorkout = Workout(date: date,
										 sticker: "",
										 stickerRotation: 0)
				modelContext.insert(newWorkout)
				newWorkout.addMoves(movesArray)
			}
		}
	}

	private func getMove(moveName: String) -> Move? {
		if let move = moves.first(where: { $0.name == moveName }) {
			return move
		}
		
		let name = MoveNames.allMoves.first {
			$0.name == moveName
		}
		if let name = name {
			return Move(moveName: name)
		} else {
			return nil
		}
	}
}
