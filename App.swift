//
//  App.swift
//  
//
//  Created by Anthony on 3/13/23.
//

import DeviceActivity


// APP: Monitor a DeviceActivitySchedule
// APP: Adding a DeviceActivityEvenet

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension DeviceActivityEvent.name {
    static let encouraged = Self("encouraged")
}

let schedule = DeviceActivitySchedule(
    intervalStart: DateComponents(hour:0, minute:0),
    intervalEnd: DateComponents(hour:23, minute:59),
    repeats: true
)

let model = myModel()
let events: [DeviceActivityEvent.Name: DeviceActicityEvent] = [
    .encouraged: DeviceActivityEvent(
        applications: model.selectionToEncourage.applicationTokesn)
        threshold: DateComponents(minute: minutes
    )
]

let center = DeviceActivityCenter()
try center.startMonitoring(.daily, during: schedule, events: event)


// APP: Choose the apps to discourage
import FamilyControls
import SwiftUI

@StateObject var model = MyModel()
@State var isPresented = false

var body: some View {
    Button("Select Apps to Discourage") {
        isPresented = true
    }
    .familyActivityPicker(isPresented: $isPresented,
                          selection: $model.selectionToDiscourage)
}
