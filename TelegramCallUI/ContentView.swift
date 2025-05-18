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
						imageName: "speaker",
						isActive: $isSpeakerActive
					)

					CallControlButton(
						imageName: "video",
						isActive: $isVideoActive
					)

					CallControlButton(
						imageName: "mute",
						isActive: $isMuteActive
					)

					CallButton(
						imageName: "end",
						backgroundColor: Color.red,
						foregroundColor: Color.white
					)
				}
			}
		}
    }
}

#Preview {
    ContentView()
}
