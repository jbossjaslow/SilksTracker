//
//  MoveDetailRowView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/5/23.
//

import SwiftUI

struct MoveDetailRowView: View {
	let move: Move
	
    var body: some View {
		NavigationLink {
			MoveDetailView(move: move)
		} label: {
			HStack {
				Text(move.name)
				
				Spacer()
				
				Text(move.workouts.count.description)
			}
		}
    }
}
