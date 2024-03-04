//
//  BackwardEventViewModel.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import Foundation
import SwiftUI

final class BackwardEventViewModel: ObservableObject {
	@AppStorage("allBackwardData") var allBackwardEventsData = Data()
	
	@Published var allBackwardEvents: [EventModel] {
        didSet {
			getFavorites()
            saveToData()
        }
    }
	@Published var favBackwardEvent = [EventModel]()
    
    init() {
        do {
            guard let data = UserDefaults.standard.data(forKey: "allBackwardData") else {
                allBackwardEvents = []
                return
            }
			allBackwardEvents = try JSONDecoder().decode([EventModel].self, from: data)
			allBackwardEvents.sort(by: { $0.date < $1 .date })
        } catch {
            allBackwardEvents = []
            print(error.localizedDescription)
        }
    }
    
    func saveToData() {
        do {
            allBackwardEventsData = try JSONEncoder().encode(allBackwardEvents)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addEvent(_ event: EventModel) {
        allBackwardEvents.append(event)
		allBackwardEvents.sort(by: { $0.date < $1 .date })
    }
    
    func deleteEvent(_ event: EventModel) {
        allBackwardEvents.removeAll(where: { $0 == event })
		allBackwardEvents.sort(by: { $0.date < $1 .date })
    }
	
	func getFavorites() {
		if let fav = allBackwardEvents.first(where: { $0.isFav == true }) {
			favBackwardEvent.insert(fav, at: 0)
		} else {
			favBackwardEvent = []
		}
	}
}
