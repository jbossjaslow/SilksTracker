//
//  ExerciseOrderToolbarContent.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/7/23.
//

import SwiftUI

struct ExerciseOrderToolbarContent: ToolbarContent {
	@Environment(AppSettings.self) var settings
	
	var body: some ToolbarContent {
		@Bindable var settings = settings
		
		ToolbarItem(placement: .topBarTrailing) {
			Picker("",
				   selection: $settings.moveListOrdering) {
				ForEach(MoveListOrderType.allCases, id: \.rawValue) { orderType in
					Text(orderType.rawValue)
						.tag(orderType)
				}
			}
				   .pickerStyle(.menu)
		}
	}
}

extension View {
	var exerciseOrderToolbar: some View {
		toolbar {
			ExerciseOrderToolbarContent()
		}
	}
}
