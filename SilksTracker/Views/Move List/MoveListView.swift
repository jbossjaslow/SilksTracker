//
//  MoveListView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/8/23.
//

import SwiftUI

/// A list of every possible move
struct MoveListView<Content: View>: View {
	@Environment(AppSettings.self) var settings
	let listRow: (MoveName) -> Content
	
	var alphabeticalMovesDict: [Character: [MoveName]] {
		Dictionary(grouping: MoveNames.allMoves) {
			$0.name.first ?? Character("")
		}
	}
	
	init(listRow: @escaping (MoveName) -> Content) {
		self.listRow = listRow
	}
	
	var body: some View {
		movesListView
			.exerciseOrderToolbar
	}
	
	private var movesListView: some View {
		List {
			switch settings.moveListOrdering {
				case .alphabetical:
					alphabeticalListContent
				case .standard:
					standardListContent
			}
		}
	}
	
	@ViewBuilder
	private var standardListContent: some View {
		ForEach(GroupedMoves.grouped) { moveGroup in
			Section {
				ForEach(moveGroup.moves) { moveName in
					listRow(moveName)
				}
			}/* header: {
				if !moveGroup.sectionTitle.isEmpty {
					Text(moveGroup.sectionTitle)
				}
			}*/
		}
	}
	
	@ViewBuilder
	private var alphabeticalListContent: some View {
		ForEach(alphabeticalMovesDict.keys.sorted(), id: \.hashValue) { firstLetter in
			Section {
				ForEach(alphabeticalMovesDict[firstLetter] ?? []) { moveName in
					listRow(moveName)
				}
			} header: {
				Text(firstLetter.description)
			}
		}
	}
}
