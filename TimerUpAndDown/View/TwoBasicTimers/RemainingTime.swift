//
//  RemainingTime.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 5/8/23.
//

import Combine
import SwiftUI

struct RemainingTime: View {
    @State var eventDate = Date().addingTimeInterval(2682163)
    @State var daysRemaining: Int = 0
    @State var hoursRemaining: Int = 0
    @State var minutesRemaining: Int = 0
    @State var secondsRemaining: Int = 0
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timerIsRunning: Bool
    
    var body: some View {
        VStack {
            VStack {
                DatePicker("Future date", selection: $eventDate, in: Date()...)
                Text("Remaining time")
                Text("\(daysRemaining < 10 ? "0\(daysRemaining)" : "\(daysRemaining)"):\(hoursRemaining < 10 ? "0\(hoursRemaining)" : "\(hoursRemaining)"):\(minutesRemaining < 10 ? "0\(minutesRemaining)" : "\(minutesRemaining)"):\(secondsRemaining < 10 ? "0\(secondsRemaining)" : "\(secondsRemaining)")")
                    .font(.system(size: 70))
                HStack(spacing: 45) {
                    Text("days")
                    Text("hours")
                    Text("minutes")
                    Text("seconds")
                }
                .padding(.leading)
                Button("Calculate") {
                    calculateRemainingTime()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 30)
            }
            .padding()
            .onAppear {
                calculateRemainingTime()
            }
            .onChange(of: timerIsRunning) {
                calculateRemainingTime()
            }
            .onReceive(timer) { _ in
                upgradeTime()
            }
        }
    }
}

struct RemainingTime_Previews: PreviewProvider {
    static var previews: some View {
        RemainingTime(timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
//			.environment(\.locale, .init(identifier: "es"))
    }
}
