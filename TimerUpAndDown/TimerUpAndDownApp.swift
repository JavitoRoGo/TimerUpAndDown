//
//  TimerUpAndDownApp.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 5/8/23.
//

import SwiftUI

@main
struct TimerUpAndDownApp: App {
    @StateObject var modelBackward = BackwardEventViewModel()
	@StateObject var modelForward = ForwardEventViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
				.onAppear(perform: modelBackward.getFavorites)
				.onAppear(perform: modelForward.getFavorites)
                .environmentObject(modelBackward)
				.environmentObject(modelForward)
        }
    }
}
