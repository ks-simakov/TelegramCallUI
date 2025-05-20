//
//  UserAvatarView.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct UserAvatarView: View {

	private let imageName: String?

	init(imageName: String? = nil) {
		self.imageName = imageName
	}

	var body: some View {
		GeometryReader { geometry in
			if let imageName {
				Image(imageName)
					.resizable()
					.scaledToFit()
					.frame(width: geometry.size.width, height: geometry.size.height)
			} else {
				Circle()
					.fill(Color.gray.opacity(0.3))
					.overlay(
						Image(systemName: "person.fill")
							.resizable()
							.scaledToFit()
							.foregroundColor(.white)
							.padding(geometry.size.width * 0.2)
					)
					.frame(width: geometry.size.width, height: geometry.size.height)
			}
		}
    }
}

#Preview {
	VStack {
		UserAvatarView()
			.frame(width: 100, height: 100)

		UserAvatarView(imageName: "user-avatar")
			.frame(width: 100, height: 100)
	}
	.background() {
		GlowGradientBackgroundView(style: .connected)
			.ignoresSafeArea()
	}
}
