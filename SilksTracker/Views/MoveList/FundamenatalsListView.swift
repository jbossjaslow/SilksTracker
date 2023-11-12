//
//  FundamenatalsListView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/15/23.
//

import SwiftData
import SwiftUI

struct FundamenatalsListView: View {
	@Query var moves: [Move]
	
	var body: some View {
		NavigationStack {
			VStack(alignment: .leading,
				   spacing: 0) {
				MoveListView {
					listRow($0)
				}
				
				Divider()
			}
				   .navigationTitle("Silks Fundamentals")
				   .navigationDestination(for: Move.self) { move in
					   MoveDetailView(move: move)
				   }
		}
	}
	
	@ViewBuilder
	private func listRow(_ moveName: MoveName) -> some View {
		if let move = moves.first(where: { $0.name == moveName.name }) {
//			MoveDetailRowView(move: move)
			NavigationLink(value: move) {
				HStack {
					Text(move.name)
					
					Spacer()
					
					Text(move.workouts.count.description)
				}
			}
		} else {
			MoveDetailRowView(move: Move(moveName: moveName))
				.disabled(true)
		}
	}
}

//#Preview {
//	FundamenatalsListView()
//		.modelContainer(previewContainer)
//}
