//
//  ForwardList.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 7/8/23.
//

import Combine
import SwiftUI

struct ForwardList: View {
    @EnvironmentObject var model: ForwardEventViewModel
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timerIsRunning: Bool
    
    var body: some View {
        List {
			if model.allForwardEvents.isEmpty {
                Text("Tap on \"+\" button to add a new event.")
            }
			ForEach($model.allForwardEvents) { $event in
                ForwardRow(event: $event, timer: timer, timerIsRunning: $timerIsRunning)
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) {
                            model.deleteEvent(event)
                        }
                    }
            }
        }
    }
}

struct ForwardList_Previews: PreviewProvider {
    static var previews: some View {
        ForwardList(timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
            .environmentObject(ForwardEventViewModel())
    }
}
