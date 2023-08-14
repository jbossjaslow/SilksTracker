//
//  StickerSelectionView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/9/23.
//

import MCEmojiPicker
import SwiftUI

struct StickerSelectionView: View {
	@Environment(\.displayScale) var displayScale
	
	@Binding var selectedSticker: String
	@Binding var stickerRotation: Angle
//	@State var stickerBorderPhase = 10.0
	
	@State private var showingEmojiPicker = false
	@State private var showingStickerSheet = false
	
	@State private var emojiImage: UIImage?
	@State private var tempRotation: Angle = .zero
	
	// MARK: - Body
    var body: some View {
		Circle()
			.stroke(style: StrokeStyle(lineWidth: 4,
									   dash: [10]))
			.frame(width: 50,
				   height: 50)
			.overlay {
				if let image = emojiImage {
					imageView(image)
				}
			}
			.onAppear {
				if !selectedSticker.isEmpty {
					Task { @MainActor in
						renderStickerToImage(selectedSticker)
					}
				}
				
//				withAnimation(dashPhaseAnimation) {
//					stickerBorderPhase = -10
//				}
			}
			.onTapGesture {
				showingStickerSheet = true
			}
			.sheet(isPresented: $showingStickerSheet) {
				sheetView
			}
    }
	
	// MARK: - Helper views
	private var sheetView: some View {
		VStack {
			if let image = emojiImage {
				imageView(image)
//					.gesture(rotation)
				
				Slider(value: $stickerRotation.degrees,
					   in: 0...360,
					   step: 1)
				.padding(.horizontal)
			} else {
				Spacer()
				
				Text("Select a sticker to begin")
			}
			
			Spacer()
			
			buttonStack
		}
		.padding(.top)
	}
	
	private func imageView(_ image: UIImage) -> some View {
		Image(uiImage: image)
			.resizable()
			.scaledToFit()
			.rotationEffect(stickerRotation + tempRotation)
	}
	
	private var buttonStack: some View {
		HStack {
			Button {
				showingEmojiPicker = true
			} label: {
				Text("Select Sticker")
					.foregroundStyle(Color.white)
					.frame(maxWidth: .infinity)
					.padding(.vertical)
					.background(Color.blue)
					.clipShape(RoundedRectangle(cornerRadius: 8))
			}
			.emojiPicker(isPresented: $showingEmojiPicker,
						 selectedEmoji: $selectedSticker,
						 arrowDirection: .down,
						 isDismissAfterChoosing: true)
			.onChange(of: selectedSticker) { _, newValue in
				Task { @MainActor in
					renderStickerToImage(newValue)
				}
			}
			
			Button {
				showingStickerSheet = false
			} label: {
				Text("Save")
					.foregroundStyle(Color.white)
					.frame(maxWidth: .infinity)
					.padding(.vertical)
					.background(Color.blue)
					.clipShape(RoundedRectangle(cornerRadius: 8))
			}
		}
		.padding(.horizontal)
	}
	
	private var rotation: some Gesture {
		RotateGesture(minimumAngleDelta: .zero)
			.onChanged {
				tempRotation = $0.rotation
			}
			.onEnded { _ in
				stickerRotation += tempRotation
				if stickerRotation.degrees > 360 {
					stickerRotation.degrees -= 360
				} else if stickerRotation.degrees < -360 {
					stickerRotation.degrees += 360
				}
				tempRotation = .zero
			}
	}
	
	// MARK: - Animations
	private var dashPhaseAnimation: Animation {
		.linear(duration: 1)
		.speed(1)
		.repeatForever(autoreverses: false)
	}
	
	// MARK: - Functions
	@MainActor
	func renderStickerToImage(_ emojiText: String) {
		let renderer = ImageRenderer(content: Text(emojiText))
		
		// make sure and use the correct display scale for this device
		renderer.scale = displayScale * 10

		emojiImage = renderer.uiImage
	}
}
