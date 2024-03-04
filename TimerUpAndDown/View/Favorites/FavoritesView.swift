//
//  FavoritesView.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 18/8/23.
//

import Combine
import SwiftUI

struct FavoritesView: View {
	@EnvironmentObject var modelBW: BackwardEventViewModel
	@EnvironmentObject var modelFW: ForwardEventViewModel
	
	@State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
	@Binding var timerIsRunning: Bool
	
	var body: some View {
		VStack {
			if modelBW.favBackwardEvent.isEmpty && modelFW.favForwardEvent.isEmpty {
				Text("Select some favorites to show them here.")
					.font(.largeTitle)
			} else {
				VStack {
					if modelBW.favBackwardEvent.isEmpty {
						Text("Choose a backward timer as your favorite to show it here.")
					} else {
						FavRemainingTimeView(event: modelBW.favBackwardEvent[0], timer: timer, timerIsRunning: $timerIsRunning)
					}
					Spacer()
					if modelFW.favForwardEvent.isEmpty {
						Text("Choose a forward timer as your favorite to show it here.")
					} else {
						FavPassedTimeView(event: modelFW.favForwardEvent[0], timer: timer, timerIsRunning: $timerIsRunning)
					}
					Spacer()
				}
			}
		}
	}
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
			.environmentObject(BackwardEventViewModel())
			.environmentObject(ForwardEventViewModel())
    }
}
