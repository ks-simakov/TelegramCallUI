//
//  CallViewModel.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

@Observable
class CallViewModel {

	enum ConnectingState: Hashable, Equatable {
		case requesting
		case ringing
		case exchangingKeys
	}

	enum ConnectionState: Hashable, Equatable {
		case connecting(ConnectingState)
		case connected(OngoingCallState)
		case disconnected
	}

	var isSpeakerActive: Bool = false {
		didSet {
			if isSpeakerActive {
			}
		}
	}
	var isVideoActive: Bool = false
	var isMuteActive: Bool = false
	var isEndCallActive: Bool = true {
		didSet {
			if !isEndCallActive {
				endCall()
			}
		}
	}
	private(set) var connectionState: ConnectionState = .disconnected
	private var testTask: Task<Void, Never>? = nil

	func endCall() {
		connectionState = .disconnected
		testTask?.cancel()
		testTask = nil
	}

	func startTestChanges() {
		testTask = Task {
			while true {
				let connectionStateChangeDelay: TimeInterval = 2

				if Task.isCancelled {
					return
				}

				connectionState = .connecting(.requesting)
				try? await Task.sleep(for: .seconds(connectionStateChangeDelay))

				connectionState = .connecting(.ringing)
				try? await Task.sleep(for: .seconds(connectionStateChangeDelay))

				connectionState = .connecting(.exchangingKeys)
				try? await Task.sleep(for: .seconds(connectionStateChangeDelay))

				var duration: TimeInterval = 0
				while true {
					if Task.isCancelled {
						return
					}

					connectionState = .connected(OngoingCallState(
						duration: duration,
						signalStrength: duration > 3 ? .weak : OngoingCallState.SignalStrength(rawValue: Int.random(in: 1...3))!
					))

					try? await Task.sleep(for: .seconds(1))
					duration += 1

					if duration > 6 {
						break
					}
				}

				connectionState = .disconnected
				try? await Task.sleep(for: .seconds(connectionStateChangeDelay))

				if Task.isCancelled {
					return
				}
			}
		}
	}

	var emojis: String {
		switch connectionState {
		case .connected(let ongoingCallState):
			return ongoingCallState.sharedKeyEmoji()
		default:
			return ""
		}
	}
}
