//
//  AddNewEvent.swift
//  TimerUpAndDown
//
//  Created by Javier Rodríguez Gómez on 6/8/23.
//

import SwiftUI

struct AddNewEvent: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var modelBW: BackwardEventViewModel
	@EnvironmentObject var modelFW: ForwardEventViewModel
    
    @State private var newEventName = ""
    @State private var newEventDate = Date()
    @State private var newEventDirection: EventModel.TimeGoes = .backward
    
   var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("TimeDirection", selection: $newEventDirection) {
                        ForEach(EventModel.TimeGoes.allCases, id:\.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    TextField("Insert the event name", text: $newEventName)
                }
                if newEventDirection == .backward {
                    DatePicker("Event date", selection: $newEventDate, in: Date()...)
                        .datePickerStyle(.graphical)
                } else {
                    DatePicker("Event date", selection: $newEventDate, in: ...Date())
                        .datePickerStyle(.graphical)
                }
            }
            .navigationTitle("Add new event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let newEvent = EventModel(name: newEventName, date: newEventDate, direction: newEventDirection)
						if newEventDirection == .backward {
							modelBW.addEvent(newEvent)
						} else {
							modelFW.addEvent(newEvent)
						}
                        dismiss()
                    }
                    .disabled(newEventName.isEmpty)
                }
            }
        }
    }
}

struct AddNewEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddNewEvent()
            .environmentObject(BackwardEventViewModel())
			.environmentObject(ForwardEventViewModel())
    }
}
