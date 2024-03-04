//
//  MainView.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import SwiftUI

struct MainView: View {
    @State private var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var timerIsRunning = true
    @State private var showingAddNew = false
    
    var body: some View {
        NavigationStack {
            TabView {
				FavoritesView(timer: timer, timerIsRunning: $timerIsRunning)
					.tabItem {
						Label("Favorites", systemImage: "heart.fill")
					}
                BackwardList(timer: timer, timerIsRunning: $timerIsRunning)
                    .tabItem {
                        Label("Remaining", systemImage: "timer")
                    }
                ForwardList(timer: timer, timerIsRunning: $timerIsRunning)
                    .tabItem {
                        Label("Passed", systemImage: "clock")
                    }
                ContentView(timer: timer, timerIsRunning: $timerIsRunning)
                    .tabItem {
                        Label("One event", systemImage: "hourglass")
                    }
            }
            .navigationTitle("Time Counters")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        timerIsRunning.toggle()
                    } label: {
                        Text(timerIsRunning ? "Stop" : "Run")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddNew = true
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddNew) {
                AddNewEvent()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
