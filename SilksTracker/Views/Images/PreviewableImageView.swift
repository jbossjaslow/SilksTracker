//
//  PreviewableImageView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/4/23.
//

import SwiftUI

struct PreviewableImageView: View {
	@Environment(GlobalProperties.self) var globalProperties
	let image: Image
	
	var body: some View {
		image
			.resizable()
			.scaledToFit()
			.onTapGesture {
				withAnimation {
					globalProperties.presentingImage = image
				}
			}
	}
}
