//
//  UserAvatarView.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct UserAvatarView: View {
    var body: some View {
        ZStack {
			Circle()
				.fill(Color.gray.opacity(0.3))
				.frame(width: 100, height: 100)
				.overlay(
					Image(systemName: "person.fill")
						.resizable()
						.scaledToFit()
						.foregroundColor(.white)
						.padding(20)
				)
		}
    }
}

#Preview {
    UserAvatarView()
}
