//
//  CallControlButton.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct CallButton: View {

	let imageName: String
	let backgroundColor: Color
	let foregroundColor: Color

	var body: some View {
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

	var imageView: Image {
		Image(imageName)
	}

	private var background: some View {
		backgroundColor
	}
}

struct CallControlButton: View {

	@Binding var isActive: Bool
	let imageName: String
	@State private var backgroundMaskScale: CGFloat = 0

	init(
		imageName: String,
		isActive: Binding<Bool>
	) {
		self.imageName = imageName
		self._isActive = isActive
		updateMask()
	}

    var body: some View {
		VStack {
			ZStack {
				// Inactive
				CallButton(
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
					imageName: imageName,
					backgroundColor: backgroundColor,
					foregroundColor: .clear
				)
				.reverseMask { backgroundMask }
			}
			.onTapGesture {
				isActive.toggle()
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
    }

	private func updateMask() {
		backgroundMaskScale = isActive ? 0 : 1
	}

	private var backgroundMask: some View {
		Circle()
			.opacity(1)
			.scaleEffect(backgroundMaskScale)
	}

	private var backgroundColor: Color {
		Color.white
	}
}

#Preview {
	@Previewable @State var isSpeakerActive = false
	@Previewable @State var isVideoActive = true
	@Previewable @State var isMuteActive = false

	ZStack {
		Color.gray

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
	.ignoresSafeArea()
}
