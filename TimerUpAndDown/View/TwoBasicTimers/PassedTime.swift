//
//  PassedTime.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 5/8/23.
//

import Combine
import SwiftUI

struct PassedTime: View {
    @State var eventDate = Date().addingTimeInterval(-2682163)
    @State var daysPassed: Int = 0
    @State var hoursPassed: Int = 0
    @State var minutesPassed: Int = 0
    @State var secondsPassed: Int = 0
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timerIsRunning: Bool
    
    var body: some View {
        VStack {
            VStack {
                DatePicker("Past date", selection: $eventDate, in: ...Date())
                Text("Passed time")
                Text("\(daysPassed < 10 ? "0\(daysPassed)" : "\(daysPassed)"):\(hoursPassed < 10 ? "0\(hoursPassed)" : "\(hoursPassed)"):\(minutesPassed < 10 ? "0\(minutesPassed)" : "\(minutesPassed)"):\(secondsPassed < 10 ? "0\(secondsPassed)" : "\(secondsPassed)")")
                    .font(.system(size: 70))
                HStack(spacing: 45) {
                    Text("days")
                    Text("hours")
                    Text("minutes")
                    Text("seconds")
                }
                .padding(.leading)
                Button("Calculate") {
                    calculatePassedTime()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 30)
            }
            .padding()
            .onAppear {
                calculatePassedTime()
            }
            .onChange(of: timerIsRunning) {
                calculatePassedTime()
            }
            .onReceive(timer) { _ in
                upgradeTime()
            }
        }
    }
}

struct PassedTime_Previews: PreviewProvider {
    static var previews: some View {
        PassedTime(timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
    }
}
