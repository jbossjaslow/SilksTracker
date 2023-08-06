//
//  WorkoutDetailRowView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/5/23.
//

import SwiftUI

struct WorkoutDetailRowView: View {
	let workout: Workout
	
	var body: some View {
		NavigationLink {
			WorkoutDetailView(workoutId: workout.id,
							  workoutDetailViewMode: .editingExistingWorkout)
		} label: {
			HStack {
				Text(workout.date.formatted(.dateTime))
				
				Spacer()
				
				Text(workout.sticker)
					.rotationEffect(Angle(degrees: workout.stickerRotation))
			}
		}
	}
}
