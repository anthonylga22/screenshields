//
//  Extension.swift
//  
//
//  Created by Anthony on 3/13/23.
//

// EXTENSION: Create a DeviceActivity Monitor
// EXTENSION: Shield the Discouraged Apps
// EXTENSION: Implement the Threshold Function
// EXTENSION: Create a ShieldConfigurationProvider 16:12
// EXTENSION: Create a ShieldActionHandler 16:50

import DeviceActivity
import ManagedSettings
import ManagedSettingsUI

class MyMonitor: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        let model = MyModel()
        let applications = model.selectionToDiscourage.applications
        
        store.shield.applications = applications.isEmpty
            ? nil : applications
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intercalDidEnd(for: activity)
        
        store.shield.applications = nil
    }
    
    //Will be called whenever an event reaches the specified threshold
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name,
                                         activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        store.shield.applications = nil
    }
}

//Creates Custom Shields
class MyShieldConfiguration: ShieldConfigurationProvider {
    override func configuration(for application: Application)
                                -> ShieldConfiguration {
        return ShieldConfiguration(
            backgroundEffect: ...
            backgroundColor: ...
            icon: ...
            title: ShieldConfiguration.Label(
                text: ...
                color: ...
            ),
            subtitle: ShieldConfiguration.Label(
                text: ...
                color: ...
            ),
            primaryButtonLabel: ShieldConfiguration.Label(
                text: ...
                color: ...
            ),
            primaryButtonBackgroundColor: ...
            secondaryButtonLabel: ShieldConfiguration.Label(
                text: ...
                color: ...
            )
        )
    }
}

//Configure Action Handlers for Primary and Secondary Buttons
class MyShieldActionExtension: ShieldActionHandler {
    override func handle(action: ShieldAction,
                         for application: Application,
                         completionHandler:
                         @escaping (ShieldActionResponse) -> Void) {
        switch action {
        case .primaryButtonPressed:
            //Gives the shield the chance to change its appearance while it waits for signal on how to proceed
            completionHandler(.defer)
        case .secondaryButtonPressed:
            completionHandler(.close)
        @unknown default:
            fatalError()
        }
    }
}
