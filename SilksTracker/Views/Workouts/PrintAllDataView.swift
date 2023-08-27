//
//  PrintAllDataView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import SwiftUI
import SwiftData

struct PrintAllDataView: View {
	@Query(sort: \Workout.date, order: .forward) var workouts: [Workout]
	
	@State var printedWorkoutsText = ""
	@State private var showPrintDataSheet = false
	
	var body: some View {
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
		.sheet(isPresented: $showPrintDataSheet) {
			sheetView
		}
	}
	
	private var sheetView: some View {
		VStack {
			TextEditor(text: $printedWorkoutsText)
//			Text(printedWorkoutsText)
			
			Button("Copy text") {
				UIPasteboard.general.string = printedWorkoutsText
				print("Copy successful")
				showPrintDataSheet = false
			}
			.foregroundStyle(Color.white)
			.padding()
			.frame(maxWidth: .infinity)
			.background(Color.blue)
			.clipShape(RoundedRectangle(cornerRadius: 8))
		}
		.padding()
	}
	
	private func generateWorkoutsText() {
		printedWorkoutsText = ""
		
		for workout in workouts {
			let workoutText = "\n\(workout.date.formatted(date: .complete, time: .shortened))".replacingOccurrences(of: " at", with: ",")
			printedWorkoutsText += workoutText
			for move in workout.moves.sorted() {
				printedWorkoutsText += "\n\(move.name)"
			}
			printedWorkoutsText += "\n"
		}
	}
}
