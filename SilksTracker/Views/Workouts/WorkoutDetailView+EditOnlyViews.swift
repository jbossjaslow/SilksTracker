//
//  WorkoutDetailView+EditOnlyViews.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/13/23.
//

import SwiftUI

extension WorkoutDetailView {
	var viewsOnlyForEditing: some View {
		HStack {
			if canModifyMoves {
				VStack {
					DatePicker("Date",
							   selection: $date,
							   displayedComponents: [.date, .hourAndMinute])
					
					editOnlyButtons
				}
				.padding(.horizontal)
			}
			
			Spacer()
			
			StickerSelectionView(selectedSticker: $selectedSticker,
								 stickerRotation: $stickerRotation)
			.disabled(!canModifyMoves)
		}
	}
	
	private var editOnlyButtons: some View {
		HStack(spacing: 4) {
			Button {
				showingBatchInput = true
			} label: {
				Text("Batch Move Input")
					.foregroundStyle(Color.white)
					.frame(maxWidth: .infinity)
					.background(Color.blue)
					.clipShape(RoundedRectangle(cornerRadius: 4))
			}
			
			Menu {
				ForEach(GroupedMoves.flows) { moveGroup in
					Button {
						for move in moveGroup.moves {
							if let foundMove = moves.first(where: { $0.name == move.name }) {
								selectedMoves.insert(foundMove)
							}
						}
					} label: {
						HStack {
							Text(moveGroup.sectionTitle)
						}
					}
				}
			} label: {
				Text("Common Flows")
					.foregroundStyle(Color.white)
					.frame(maxWidth: .infinity)
					.background(Color.blue)
					.clipShape(RoundedRectangle(cornerRadius: 4))
			}

		}
	}
}
