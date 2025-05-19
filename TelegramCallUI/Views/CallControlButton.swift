//
//  CallControlButton.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct CallButton: View {

	let title: String
	let imageName: String
	let backgroundColor: Color
	let foregroundColor: Color

	var body: some View {
		VStack {
			ZStack {
				imageView
					.padding(4)
					.background(background)
					.clipShape(Circle())
					.reverseMask({
						imageView
					})

				imageView
					.renderingMode(.template)
					.foregroundColor(foregroundColor)
			}
		}
	}

	private var imageView: Image {
		Image(imageName)
	}

	private var background: some View {
		backgroundColor
	}
}

struct CallControlButton: View {

	// MARK: - Parameters

	let title: String
	let imageName: String
	private(set) var backgroundColor: Color = .white
	private(set) var foregroundColor: Color = .clear
	@Binding var isActive: Bool

	// MARK: - Private state

	@State private var backgroundMaskScale: CGFloat = 0

	enum AnimationPhase: CaseIterable {
		case start, middle, end
	}

	// MARK: - Init

	// MARK: - Body

    var body: some View {
		VStack {
			ZStack {
				// Inactive
				CallButton(
					title: title,
					imageName: imageName,
					backgroundColor: backgroundColor.opacity(0.2),
					foregroundColor: .white
				)
				.mask {
					Circle()
						.scaleEffect(backgroundMaskScale)
				}

				// Active
				CallButton(
					title: title,
					imageName: imageName,
					backgroundColor: backgroundColor,
					foregroundColor: foregroundColor
				)
				.reverseMask { backgroundMask }
			}

			Text(title)
				.font(.caption)
				.foregroundColor(.white)
		}
		.gesture(tapGesture)
		.phaseAnimator(AnimationPhase.allCases, trigger: isActive) { content, phase in
			let scaleEffect = switch phase {
			case .start: 	1.0
			case .middle: 	0.9
			case .end: 		1.0
			}

			content.scaleEffect(scaleEffect)
		} animation: { phase in
			switch phase {
			case .start, .end: 	.bouncy
			case .middle: 		.easeInOut(duration: 0.1)
			}
		}
		.onChange(of: isActive) { oldValue, newValue in
			withAnimation(.spring()) {
				updateMask()
			}
		}
		.task {
			updateMask()
		}
    }

	// MARK: - Private

	private var tapGesture: some Gesture {
		TapGesture()
			.onEnded { _ in
				isActive.toggle()
			}
	}

	private func updateMask() {
		backgroundMaskScale = isActive ? 0 : 1
	}

	private var backgroundMask: some View {
		Circle()
			.opacity(1)
			.scaleEffect(backgroundMaskScale)
	}
}

// MARK: - Preview

#Preview {
	@Previewable @State var isSpeakerActive = false
	@Previewable @State var isVideoActive = true
	@Previewable @State var isMuteActive = false
	@Previewable @State var isEndCallActive = true

	ZStack {
		GlowGradientBackgroundView(style: .connecting)
			.ignoresSafeArea()

		VStack {
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
