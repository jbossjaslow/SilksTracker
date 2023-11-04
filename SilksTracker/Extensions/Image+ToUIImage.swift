//
//  Image+ToUIImage.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//

import SwiftUI

extension Image {
	@MainActor
	var uiImage: UIImage? {
		return ImageRenderer(content: self).uiImage
	}
}
