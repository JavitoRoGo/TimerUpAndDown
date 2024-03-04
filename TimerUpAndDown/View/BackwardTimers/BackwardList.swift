//
//  BackwardList.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import Combine
import SwiftUI

struct BackwardList: View {
    @EnvironmentObject var model: BackwardEventViewModel
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timerIsRunning: Bool
    
    var body: some View {
        List {
			if model.allBackwardEvents.isEmpty {
                Text("Tap on \"+\" button to add a new event.")
            }
			ForEach($model.allBackwardEvents) { $event in
                BackwardRow(event: $event, timer: timer, timerIsRunning: $timerIsRunning)
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) {
                            model.deleteEvent(event)
                        }
                    }
					.swipeActions(edge: .leading) {
						Button("Go!") {
							if let index = model.allBackwardEvents.firstIndex(of: event) {
								// add one year to event date
								model.allBackwardEvents[index].date += 31536000
								timerIsRunning.toggle()
								DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
									timerIsRunning.toggle()
								}
							}
						}
						.tint(.green)
					}
            }
        }
    }
}

struct BackwardList_Previews: PreviewProvider {
    static var previews: some View {
        BackwardList(timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
            .environmentObject(BackwardEventViewModel())
    }
}
