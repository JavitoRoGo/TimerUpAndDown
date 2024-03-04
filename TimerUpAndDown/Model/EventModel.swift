//
//  EventModel.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import Foundation

struct EventModel: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    var date: Date
    let direction: TimeGoes
	var isFav: Bool
    
	init(id: UUID = UUID(), name: String, date: Date, direction: TimeGoes, isFav: Bool = false) {
        self.id = id
        self.name = name
        self.date = date
        self.direction = direction
		self.isFav = isFav
    }
}

extension EventModel {
    enum TimeGoes: String, Codable, CaseIterable {
        case backward = "Count down"
        case forward = "Count up"
    }
    
    static let example = Self.init(name: "Future event", date: Date().addingTimeInterval(123456789), direction: .backward, isFav: true)
}
