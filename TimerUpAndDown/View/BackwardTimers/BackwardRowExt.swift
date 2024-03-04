//
//  BackwardRowExt.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import Foundation

extension BackwardRow {
    func calculateRemainingTime() {
        let totalSeconds = -Int(Date().timeIntervalSince(event.date))
        if totalSeconds <= 0 {
            daysRemaining = 0
            hoursRemaining = 0
            minutesRemaining = 0
            secondsRemaining = 0
            return
        }
        daysRemaining = totalSeconds / (24 * 3600)
        hoursRemaining = (totalSeconds / 3600) % 24
        minutesRemaining = (totalSeconds / 60) % 60
        secondsRemaining = totalSeconds % 60
    }
    
    func upgradeTime() {
		if model.allBackwardEvents.isEmpty { return }
        if -Int(Date().timeIntervalSince(event.date)) < 0 { return }
        
        if timerIsRunning {
            if secondsRemaining == 0 {
                secondsRemaining = 59
                if minutesRemaining == 0 {
                    minutesRemaining = 59
                    if hoursRemaining == 0 {
                        hoursRemaining = 23
                        daysRemaining -= 1
                    } else {
                        hoursRemaining -= 1
                    }
                } else {
                    minutesRemaining -= 1
                }
            } else {
                secondsRemaining -= 1
            }
        }
    }
}
