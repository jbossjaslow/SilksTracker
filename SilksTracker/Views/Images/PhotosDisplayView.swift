//
//  PhotosDisplay.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/12/23.
//

import SwiftUI

struct PhotosDisplayView: View {
	@Binding var selectedImages: [SilksImage]
	let isActivelyEditing: Bool
	let deleteImage: (SilksImage) -> Void
	
	var body: some View {
		if isActivelyEditing {
			ImageSelectionView(selectedImages: $selectedImages,
							   onDelete: deleteImage)
		} else {
			ScrollView(.vertical) {
				LazyVGrid(columns: Array(repeating: GridItem(),
										 count: 4),
						  spacing: 10) {
					ForEach(selectedImages, id: \.fileName) { selectedImage in
						PreviewableImageView(image: selectedImage.image)
							.containerRelativeFrame(.horizontal,
													count: 4,
													span: 1,
													spacing: 10)
					}
				}
			}
		}
	}
}
