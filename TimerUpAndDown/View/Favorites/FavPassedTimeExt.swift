//
//  FavPassedTimeExt.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 19/8/23.
//

import Foundation

extension FavPassedTimeView {
	func calculatePassedTime() {
		let totalSeconds = Int(Date().timeIntervalSince(event.date))
		daysRemaining = totalSeconds / (24 * 3600)
		hoursRemaining = (totalSeconds / 3600) % 24
		minutesRemaining = (totalSeconds / 60) % 60
		secondsRemaining = totalSeconds % 60
	}
	
	func upgradeTime() {
		if timerIsRunning {
			if secondsRemaining == 59 {
				secondsRemaining = 0
				if minutesRemaining == 59 {
					minutesRemaining = 0
					if hoursRemaining == 23 {
						hoursRemaining = 0
						daysRemaining += 1
					} else {
						hoursRemaining += 1
					}
				} else {
					minutesRemaining += 1
				}
			} else {
				secondsRemaining += 1
			}
		}
	}
}
