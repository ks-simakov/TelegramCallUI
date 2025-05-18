//
//  ContentView.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct ContentView: View {

	@State var isSpeakerActive = false
	@State var isVideoActive = true
	@State var isMuteActive = false
	@State var isEndCallActive = true

	var body: some View {
		ZStack {
			Color.gray
				.edgesIgnoringSafeArea(.all)

			VStack {
				Text("Title")
					.font(.headline)
					.foregroundColor(.white)

				Spacer()

				HStack(spacing: 24) {
					CallControlButton(
						title: "speaker",
						imageName: "speaker",
						isActive: $isSpeakerActive
					)

					CallControlButton(
						title: "video",
						imageName: "video",
						isActive: $isVideoActive
					)

					CallControlButton(
						title: "mute",
						imageName: "mute",
						isActive: $isMuteActive
					)

					CallControlButton(
						title: "end call",
						imageName: "end",
						backgroundColor: Color.red,
						foregroundColor: Color.white,
						isActive: $isEndCallActive
					)
				}
			}
		}
    }
}

#Preview {
    ContentView()
}
