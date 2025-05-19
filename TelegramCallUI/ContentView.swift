//
//  ContentView.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct ContentView: View {

	@State var viewModel = CallsService().startCall()
	

	var body: some View {
		VStack(spacing: 8) {
			HStack(spacing: 24) {
				// TODO: Back button
				Spacer()

				switch viewModel.connectionState {
				case .connected(let ongoingCallState):
					Text(ongoingCallState.sharedKeyEmoji())
						.font(.title2)
						.foregroundColor(.white)
						.transition(
							.opacity.animation(.linear(duration: 0.2))
							.combined(with: .scale(scale: 0.2).animation(.linear(duration: 0.2)))
						)
				default:
					Spacer()
				}
			}
			.safeAreaPadding(.horizontal)
			.frame(height: 44)

			Spacer().frame(height: 180)

			UserAvatarView()

			Text("John Doe")
				.font(.title)
				.foregroundColor(.white)

			switch viewModel.connectionState {
			case .connecting(let connectingState):
				connectingStateView(connectingState)
					.animation(.linear(duration: 0.2), value: viewModel.connectionState)
					.transition(
						.asymmetric(
							insertion: .offset(y: 32).animation(.easeOut(duration: 0.3))
								.combined(with: .scale(scale: 0.2).animation(.linear(duration: 0.2)))
								.combined(with: .opacity.animation(.linear(duration: 0.3))),
							removal: .opacity.animation(.linear(duration: 0.4))
								.combined(with: .scale(scale: 0.2).animation(.linear(duration: 0.2)))
						)
					)
			case .connected(let ongoingCallState):
				ongoingCallStateView(ongoingCallState)
			case .disconnected:
				Text("Disconnected")
					.font(.subheadline)
					.foregroundColor(.white)
			}

			Spacer()

			HStack(spacing: 24) {
				CallControlButton(
					title: "speaker",
					imageName: "speaker",
					isActive: $viewModel.isSpeakerActive
				)

				CallControlButton(
					title: "video",
					imageName: "video",
					isActive: $viewModel.isVideoActive
				)

				CallControlButton(
					title: "mute",
					imageName: "mute",
					isActive: $viewModel.isMuteActive
				)

				CallControlButton(
					title: "end call",
					imageName: "end",
					backgroundColor: Color.red,
					foregroundColor: Color.white,
					isActive: $viewModel.isEndCallActive
				)
			}
		}
		.background(
			GlowGradientBackgroundView(style: gradientStyle)
				.edgesIgnoringSafeArea(.all)
				.animation(.linear(duration: 0.2), value: viewModel.connectionState)
		)
		.task {
			viewModel.startTestChanges()
		}
    }

	@ViewBuilder
	private func connectingStateView(
		_ connectingState: CallViewModel.ConnectingState
	) -> some View {
		switch connectingState {
		case .requesting:
			ProgressText(text: "Requesting")
		case .ringing:
			ProgressText(text: "Ringing")
		case .exchangingKeys:
			ProgressText(text: "Exchanging encryption keys")
		}
	}

	@State private var value1 = 2

	@ViewBuilder
	private func ongoingCallStateView(
		_ ongoingCallState: OngoingCallState
	) -> some View {
		VStack {
			HStack {
				SignalStrengthView(signalStrength: ongoingCallState.signalStrength)
					.animation(.linear(duration: 0.2), value: viewModel.connectionState)

				Text("\(ongoingCallState.duration.mmSS)")
					.font(.callout)
					.foregroundColor(.white)
			}

			if ongoingCallState.signalStrength == .weak {
				Text("Weak network signal")
					.font(.subheadline)
					.foregroundColor(.white)
					.padding(.horizontal, 12)
					.padding(.vertical, 4)
					.background(.white.opacity(0.2))
					.clipShape(Capsule())
					.transition(
						.asymmetric(
							insertion: .scale(scale: 0.2).animation(.spring(duration: 0.2))
								.combined(with: .opacity.animation(.linear(duration: 0.3))),
							removal: .opacity.animation(.linear(duration: 0.4))
								.combined(with: .scale(scale: 0.2).animation(.linear(duration: 0.2)))
						)
					)
			}
		}
	}

	private var gradientStyle: GlowGradientBackgroundView.Style {
		switch viewModel.connectionState {
		case .connecting:
			return .connecting
		case .connected(let ongoingCallState):
			if ongoingCallState.signalStrength == .weak {
				return .weakSignal
			} else {
				return .connected
			}
		case .disconnected:
			return .connecting
		}
	}
}

#Preview {
    ContentView()
}
