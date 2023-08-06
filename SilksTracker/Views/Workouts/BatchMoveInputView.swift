//
//  BatchMoveInputView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/9/23.
//

import SwiftUI

struct BatchMoveInputView: View {
	@Environment(\.dismiss) private var dismiss
	@Binding var selectedMoves: Set<Move>
	@State var text = ""
	@FocusState var keyboardFocused: Bool
	
    var body: some View {
		VStack {
			HStack {
				Text("Batch Move Input")
					.font(.title)
				
				Spacer()
				
				saveButton
			}
			
			TextEditor(text: $text)
				.focused($keyboardFocused)
				.toolbar {
					ToolbarItemGroup(placement: .keyboard) {
						Spacer()
						
						Button("Done") {
							keyboardFocused = false
						}
					}
				}
		}
		.padding()
		.onAppear {
			keyboardFocused = true
		}
		.onDisappear {
			keyboardFocused = false
		}
    }
	
	private var saveButton: some View {
		Button {
			let lines = text.split(whereSeparator: \.isNewline)
			for line in lines {
				if let move = MoveNames.allMoves.first(where: { $0.name == line }) {
					selectedMoves.insert(Move(moveName: move))
				}
			}
			dismiss()
		} label: {
			Text("Save")
				.foregroundStyle(Color.white)
		}
	}
}
