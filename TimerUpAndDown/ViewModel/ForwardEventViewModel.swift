//
//  ForwardEventViewModel.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 19/8/23.
//

import Foundation
import SwiftUI

final class ForwardEventViewModel: ObservableObject {
	@AppStorage("allForwardData") var allForwardEventsData = Data()
	
	@Published var allForwardEvents: [EventModel] {
		didSet {
			getFavorites()
			saveToData()
		}
	}
	@Published var favForwardEvent = [EventModel]()
	
	init() {
		do {
			guard let data = UserDefaults.standard.data(forKey: "allForwardData") else {
				allForwardEvents = []
				return
			}
			allForwardEvents = try JSONDecoder().decode([EventModel].self, from: data)
			allForwardEvents.sort(by: { $0.date < $1 .date })
		} catch {
			allForwardEvents = []
			print(error.localizedDescription)
		}
	}
	
	func saveToData() {
		do {
			allForwardEventsData = try JSONEncoder().encode(allForwardEvents)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func addEvent(_ event: EventModel) {
		allForwardEvents.append(event)
		allForwardEvents.sort(by: { $0.date < $1 .date })
	}
	
	func deleteEvent(_ event: EventModel) {
		allForwardEvents.removeAll(where: { $0 == event })
		allForwardEvents.sort(by: { $0.date < $1 .date })
	}
	
	func getFavorites() {
		if let fav = allForwardEvents.first(where: { $0.isFav == true }) {
			favForwardEvent.insert(fav, at: 0)
		} else {
			favForwardEvent = []
		}
	}
}
