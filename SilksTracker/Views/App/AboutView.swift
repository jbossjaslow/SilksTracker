//
//  AboutScreen.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/12/23.
//

import SwiftUI

struct AboutView: View {
	var body: some View {
		VStack(spacing: 20) {
			Spacer()
			
			if let url = URL(string: "mailto:jbossjaslow@gmail.com") {
				Group {
					Text("This is a passion project of mine. If you have questions, comments, or other feedback, please feel free to contact me at ") +
					Text("jbossjaslow@gmail.com")
						.foregroundStyle(.blue)
				}
				.onTapGesture {
					UIApplication.shared.open(url)
				}
				.multilineTextAlignment(.leading)
			}
			
			HStack {
				Text("Silks sheet courtesy of Aerial CLT")
					.foregroundStyle(.secondary)
				
				Spacer()
			}
			
			Spacer()
			
			if let version = UIApplication.appVersion {
				Text("Version \(version)")
					.foregroundStyle(.tertiary)
			}
		}
		.padding(.horizontal)
	}
}
