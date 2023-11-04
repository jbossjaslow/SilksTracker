//
//  ImageSelectionView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/15/23.
//

import Observation
import PhotosUI
import SwiftUI

// TODO: PhotoPicker replaces entire array any time user goes into the picker. If user edits existing workout, how can we prevent all of their photos from being wiped out since opening the picker would get rid of them all?
struct ImageSelectionView: View {
	@State var photoPickerItems: [PhotosPickerItem] = []
//	@State var selectedImages: [Image] = []
	@Binding var selectedImages: [SilksImage]
	
	@State var showingProgressBar = false
	@State var progressBarProgress = 0.0
	
	let onDelete: (SilksImage) -> Void
	
	let columns = [
		GridItem(),
		GridItem(),
		GridItem(),
		GridItem()
	]
	
	init(selectedImages: Binding<[SilksImage]>,
		 onDelete: @escaping (SilksImage) -> Void) {
		_selectedImages = selectedImages
		self.onDelete = onDelete
	}
	
    var body: some View {
		ScrollView(.vertical) {
			LazyVGrid(columns: columns,
					  spacing: 10) {
				ForEach(selectedImages.indices, id: \.self) { thumbnailIndex in
					selectedImages[thumbnailIndex].image
						.resizable()
						.scaledToFit()
						.containerRelativeFrame(.horizontal,
												count: 4,
												span: 1,
												spacing: 10)
						.overlay(alignment: .topTrailing) {
							Image(systemName: "xmark.circle.fill")
								.foregroundStyle(.white, .red)
								.onTapGesture {
									guard !showingProgressBar else {
										return
									}
									
									withAnimation {
										onDelete(selectedImages[thumbnailIndex])
										selectedImages.remove(atOffsets: [thumbnailIndex])
//										photoPickerItems.remove(atOffsets: [thumbnailIndex])
									}
								}
						}
				}
				
				PhotosPicker(selection: $photoPickerItems,
							 matching: .images) {
					Image(systemName: "plus")
						.font(.system(size: 56))
						.foregroundStyle(Color(.Colors.primaryText))
						.background(Color(.Colors.primaryTextBackground))
						.clipShape(RoundedRectangle(cornerRadius: 8))
				}
			}
        }
		.overlay {
			if showingProgressBar {
				ZStack {
					Color.black.opacity(0.5).ignoresSafeArea()
					
					VStack {
						Text("Importing images")
							.foregroundStyle(.white)
						
						ProgressView(value: progressBarProgress)
							.progressViewStyle(CircularProgressView(color: .green))
							.frame(width: 50,
								   height: 50)
					}
				}
			}
		}
		.task(id: photoPickerItems) {
			guard !photoPickerItems.isEmpty else {
				// no need to evaluate empty array
				return
			}
			
			progressBarProgress = 0
			withAnimation {
				showingProgressBar = true
			}
			selectedImages.removeAll {
				$0.fileName.contains("TEMPORARYIMAGE")
			}
			for index in photoPickerItems.indices {
				// Using `Data` since Image only supports png as transferable type, thereby causing weird rotation issues on non-png images
				if let data = try? await photoPickerItems[index].loadTransferable(type: Data.self),
				   let uiImage = UIImage(data: data) {
					progressBarProgress = Double(index + 1)/Double(photoPickerItems.count)
					withAnimation {
						let image = Image(uiImage: uiImage)
						selectedImages.append(SilksImage(image: image,
														 fileName: "TEMPORARYIMAGE_\(selectedImages.count)"))
					}
				}
			}
			withAnimation {
				showingProgressBar = false
			}
		}
    }
}
