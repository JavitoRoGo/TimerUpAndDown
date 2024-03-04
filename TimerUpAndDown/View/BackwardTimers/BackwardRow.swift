//
//  BackwardRow.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import Combine
import SwiftUI

struct BackwardRow: View {
	@EnvironmentObject var model: BackwardEventViewModel
    @Binding var event: EventModel
    
    @State var daysRemaining: Int = 0
    @State var hoursRemaining: Int = 0
    @State var minutesRemaining: Int = 0
    @State var secondsRemaining: Int = 0
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timerIsRunning: Bool
    
    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("\(event.name) - \(event.date.formatted(date: .numeric, time: .omitted))")
				Text("\(daysRemaining < 10 ? "0\(daysRemaining)" : "\(daysRemaining)"):\(hoursRemaining < 10 ? "0\(hoursRemaining)" : "\(hoursRemaining)"):\(minutesRemaining < 10 ? "0\(minutesRemaining)" : "\(minutesRemaining)"):\(secondsRemaining < 10 ? "0\(secondsRemaining)" : "\(secondsRemaining)")")
					.font(.title)
			}
			Spacer()
			Button {
				if event.isFav {
					event.isFav = false
				} else {
					if model.favBackwardEvent.isEmpty {
						event.isFav = true
					} else {
						if let index = model.allBackwardEvents.firstIndex(where: { $0.isFav }) {
							model.allBackwardEvents[index].isFav = false
							event.isFav = true
						}
					}
				}
			} label: {
				Image(systemName: event.isFav ? "heart.fill" : "heart")
					.foregroundColor(event.isFav ? .pink : .gray.opacity(0.4))
					.font(.largeTitle)
			}
			.buttonStyle(.plain)
		}
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

struct BackwardRow_Previews: PreviewProvider {
    static var previews: some View {
		BackwardRow(event: .constant(EventModel.example), timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
			.environmentObject(BackwardEventViewModel())
    }
}
