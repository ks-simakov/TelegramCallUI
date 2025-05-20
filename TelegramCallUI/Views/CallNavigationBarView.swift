//
//  CallNavigationBarView.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 20.05.25.
//

import SwiftUI

struct CallNavigationBarView: View {

	let ongoingCallState: OngoingCallState

	@State private var spacing: CGFloat = 4
	private let animationDuration: Double = 0.3

    var body: some View {
		HStack {
			Button(action: {
			}) {
				HStack(spacing: spacing) {
					Image(systemName: "chevron.left")
						.font(.title3)
						.foregroundColor(.white)

					Text("Back")
						.font(.subheadline)
				}
				.foregroundColor(.white)
			}

			Spacer()

			HStack(spacing: spacing) {
				ForEach(ongoingCallState.emojis, id: \.self) { emoji in
					Text(emoji)
						.font(.title2)
						.foregroundColor(.white)

				}
			}

		}
		.safeAreaPadding(.horizontal)
		.transition(.opacity.animation(.linear(duration: animationDuration)))
		.onAppear {
			spacing = 24
			withAnimation(.linear(duration: animationDuration)) {
				spacing = 4
			}
		}
    }
}

#Preview {

	@Previewable @State var counter = 0

	ZStack(alignment: .top) {
		GlowGradientBackgroundView(style: .connected)
			.ignoresSafeArea()

		if counter % 2 == 0 {
			CallNavigationBarView(
				ongoingCallState: .init(
					duration: 1,
					signalStrength: .good
				)
			)
		}
	}
	.task {
		while true {
			counter = 0
			try? await Task.sleep(for: .seconds(2))

			counter = 1
			try? await Task.sleep(for: .seconds(0.3))
		}
	}
}
