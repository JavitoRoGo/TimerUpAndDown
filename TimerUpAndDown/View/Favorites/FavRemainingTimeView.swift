//
//  FavRemainingTimeView.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 18/8/23.
//

import Combine
import SwiftUI

struct FavRemainingTimeView: View {
	let event: EventModel
	
	@State var daysRemaining: Int = 0
	@State var hoursRemaining: Int = 0
	@State var minutesRemaining: Int = 0
	@State var secondsRemaining: Int = 0
	@State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
	@Binding var timerIsRunning: Bool
	
	var body: some View {
		VStack {
			VStack {
				Text("\(event.name)\n\(event.date.formatted(date: .long, time: .shortened))")
					.font(.title2)
				Text("\(daysRemaining < 10 ? "0\(daysRemaining)" : "\(daysRemaining)"):\(hoursRemaining < 10 ? "0\(hoursRemaining)" : "\(hoursRemaining)"):\(minutesRemaining < 10 ? "0\(minutesRemaining)" : "\(minutesRemaining)"):\(secondsRemaining < 10 ? "0\(secondsRemaining)" : "\(secondsRemaining)")")
					.font(.system(size: 55))
				HStack() {
					Spacer()
					Text("dd")
					Spacer()
					Text("hh")
					Spacer()
					Text("mm")
					Spacer()
					Text("ss")
					Spacer()
				}
				.foregroundColor(.gray)
				.padding(.leading)
			}
			.padding()
			.onAppear {
				calculateRemainingTime()
			}
			.onChange(of: timerIsRunning) { _ in
				calculateRemainingTime()
			}
			.onReceive(timer) { _ in
				upgradeTime()
			}
		}
	}
}

struct FavRemainingTimeView_Previews: PreviewProvider {
    static var previews: some View {
		FavRemainingTimeView(event: EventModel.example, timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
    }
}
