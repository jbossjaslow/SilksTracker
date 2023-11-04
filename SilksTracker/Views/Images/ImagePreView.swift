//
//  ImagePreView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/4/23.
//

import SwiftUI

struct ImagePreView: View {
	@Environment(GlobalProperties.self) var globalProperties
	
	var body: some View {
		VStack(alignment: .trailing) {
			Button("Close") {
				withAnimation {
					globalProperties.presentingImage = nil
				}
			}
			
			if let image = globalProperties.presentingImage {
				GeometryReader { proxy in
					image
						.resizable()
						.scaledToFit()
						.frame(width: proxy.size.width, height: proxy.size.height)
						.modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
				}
			}
		}
		.padding()
		.background(.regularMaterial)
	}
}

struct ImageModifier: ViewModifier {
	private var contentSize: CGSize
	private var min: CGFloat = 1.0
	private var max: CGFloat = 3.0
	@State var currentScale: CGFloat = 0.0
	@State var totalScale: CGFloat = 1.0
	
	init(contentSize: CGSize) {
		self.contentSize = contentSize
	}
	
	var doubleTapGesture: some Gesture {
		TapGesture(count: 2)
			.onEnded {
				if totalScale <= min {
					totalScale = max
				} else if totalScale >= max {
					totalScale = min
				} else {
					totalScale = ((max - min) * 0.5 + min) < totalScale ? max : min
				}
			}
	}
	
	var pinchGesture: some Gesture {
		MagnifyGesture(minimumScaleDelta: 0)
			.onChanged { value in
				currentScale = value.magnification - 1
			}
			.onEnded { value in
				totalScale += currentScale
				currentScale = 0
				if totalScale <= min {
					totalScale = min
				} else if totalScale >= max {
					totalScale = max
				}
			}
	}
	
	func body(content: Content) -> some View {
		ScrollView([.horizontal, .vertical],
				   showsIndicators: false) {
			content
				.frame(width: contentSize.width * (currentScale + totalScale),
					   height: contentSize.height * (currentScale + totalScale))
				.scaleEffect(currentScale + totalScale)
		}
				   .gesture(pinchGesture)
				   .gesture(doubleTapGesture)
				   .animation(.easeInOut, value: totalScale)
	}
}
