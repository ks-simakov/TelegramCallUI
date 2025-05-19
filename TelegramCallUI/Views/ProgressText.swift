//
//  ProgressText.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct ProgressText: View {

	let text: String
	let foregroundColor: Color = .white
	@State var isAnimating: Bool = false

	private let dotSize: CGFloat = 6
	private let dotScaleLow: CGFloat = 0.3
	private let animationDuration: TimeInterval = 0.6
	private let dotsCount: Int = 3

    var body: some View {
		HStack(spacing: 6) {
			Text(text)
				.font(.callout)
				.foregroundColor(foregroundColor)

			HStack(spacing: 2) {
				ForEach(0..<dotsCount, id: \.self) { index in
					let delay = delay(for: index)
					Circle()
						.fill(foregroundColor)
						.scaleEffect(isAnimating ? 1 : dotScaleLow)
						.animation(
							.easeInOut(duration: animationDuration - delay)
							.delay(delay)
							.repeatForever(autoreverses: true),
							value: isAnimating
						)
				}
			}
			.frame(height: dotSize)
		}
		.task {
			isAnimating = true
		}
    }

	// MARK: - Private methods

	private func delay(for index: Int) -> Double {
		Double(index) * animationDuration / Double(dotsCount + 1)
	}
}

#Preview {
	ZStack {
		GlowGradientBackgroundView(style: .connecting)
			.ignoresSafeArea()

		ProgressText(
			text: "Requesting"
		)
	}

}
