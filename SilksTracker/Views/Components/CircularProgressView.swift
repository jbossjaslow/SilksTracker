//
//  CircularProgressView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//

import SwiftUI

struct CircularProgressView: ProgressViewStyle {
	let color: Color
	
	func makeBody(configuration: Configuration) -> some View {
		ZStack {
			Circle()
				.stroke(color.opacity(0.5),
						lineWidth: 4)
			Circle()
				.trim(from: 0,
					  to: configuration.fractionCompleted ?? 0)
				.stroke(color,
						style: StrokeStyle(
							lineWidth: 4,
							lineCap: .round
						)
				)
				.rotationEffect(.degrees(-90))
				.animation(.easeOut,
						   value: configuration.fractionCompleted)
			
		}
	}
}
