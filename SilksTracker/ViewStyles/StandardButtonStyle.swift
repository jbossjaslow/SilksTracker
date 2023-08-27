//
//  StandardButtonStyle.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import SwiftUI

struct StandardButtonStyle: ViewModifier {
	func body(content: Content) -> some View {
		content
			.foregroundStyle(Color.white)
			.padding()
			.frame(maxWidth: .infinity)
			.background(Color.blue)
			.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}

extension View {
	var standardButtonStyle: some View {
		modifier(StandardButtonStyle())
	}
}
