//
//  PassedTimeExt.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import Foundation

extension PassedTime {
    func calculatePassedTime() {
        let totalSeconds = Int(Date().timeIntervalSince(eventDate))
        daysPassed = totalSeconds / (24 * 3600)
        hoursPassed = (totalSeconds / 3600) % 24
        minutesPassed = (totalSeconds / 60) % 60
        secondsPassed = totalSeconds % 60
    }
    
    func upgradeTime() {
        if timerIsRunning {
            if secondsPassed == 59 {
                secondsPassed = 0
                if minutesPassed == 59 {
                    minutesPassed = 0
                    if hoursPassed == 23 {
                        hoursPassed = 0
                        daysPassed += 1
                    } else {
                        hoursPassed += 1
                    }
                } else {
                    minutesPassed += 1
                }
            } else {
                secondsPassed += 1
            }
        }
    }
}
