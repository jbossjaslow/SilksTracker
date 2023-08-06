//
//  MoveDetailView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/5/23.
//

import SwiftData
import SwiftUI

struct MoveDetailView: View {
	let move: Move
	
	var body: some View {
		List {
			Section {
				ForEach(move.workouts.sorted()) { workout in
					WorkoutDetailRowView(workout: workout)
				}
			} header: {
				Text("Workouts")
			}
		}
		.navigationTitle(move.name)
	}
}
