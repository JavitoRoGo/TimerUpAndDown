//
//  RemainingTimeExt.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import Foundation

extension RemainingTime {
    func calculateRemainingTime() {
        let totalSeconds = -Int(Date().timeIntervalSince(eventDate))
        daysRemaining = totalSeconds / (24 * 3600)
        hoursRemaining = (totalSeconds / 3600) % 24
        minutesRemaining = (totalSeconds / 60) % 60
        secondsRemaining = totalSeconds % 60
    }
    
    func upgradeTime() {
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
