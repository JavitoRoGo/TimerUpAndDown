//
//  ContentView.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 5/8/23.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timerIsRunning: Bool
    
    var body: some View {
        VStack {
            PassedTime(timer: timer, timerIsRunning: $timerIsRunning)
            Spacer()
            RemainingTime(timer: timer, timerIsRunning: $timerIsRunning)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(timer: Publishers.Autoconnect<Timer.TimerPublisher>(upstream: .init(interval: 1.0, runLoop: .main, mode: .common)), timerIsRunning: .constant(true))
    }
}
