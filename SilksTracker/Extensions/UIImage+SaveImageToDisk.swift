//
//  UIImage+SaveImageToDisk.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 10/29/23.
//
// Adapted from https://stackoverflow.com/questions/66031481/saving-a-reference-to-an-image-in-camera-roll-to-recall-later-in-app

import UIKit

// TODO:  - Update this to use URLs instead to power AsyncImage --> https://developer.apple.com/tutorials/sample-apps/imagegallery
extension UIImage {
	/// Save an image to disk
	/// - Parameter fileName: The name of the image path
	/// - Returns: Whether the operation was successful
	func saveImage(fileName: String) -> Bool {
		let fileURL = Self.getDocumentsDirectory().appendingPathComponent(fileName)
//		guard let data = self.jpegData(compressionQuality: 1) else { return }
		guard let data = pngData() else {
			print("Data could not be converted to PNG")
			return false
		}
		
		// Checks if file exists, removes it if so.
		Self.removeImage(fileName: fileName)
		do {
			try data.write(to: fileURL)
			return true
		} catch {
			print("Error saving file with error: \(error.localizedDescription)")
			return false
		}
	}
	
	static func loadImageFromDiskWith(fileName: String) -> UIImage? {
		let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
		return UIImage(contentsOfFile: fileURL.path)
	}
	
	static func removeImage(fileName: String) {
		let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
		
		if FileManager.default.fileExists(atPath: fileURL.path) {
			do {
				try FileManager.default.removeItem(atPath: fileURL.path)
				print("Removed image")
			} catch let removeError {
				print("Couldn't remove file at path", removeError)
			}
		}
	}
	
	private static func getDocumentsDirectory() -> URL {
		guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
			preconditionFailure("Unable to get documents directory")
		}
		return path
	}
}
