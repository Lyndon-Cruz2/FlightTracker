//
//  AppDelegate.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 10/2/24.
//

import SwiftUI
import BackgroundTasks
import ActivityKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set the minimum background fetch interval
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        print("Loading fetch registered")

        // Register the background task when the app launches
        registerBackgroundTasks()
        return true
    }

    // Register background tasks
    func registerBackgroundTasks() {
        print("Background fetch registered")
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.test.FlightTracker", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }

    // Handle the background refresh task
    func handleAppRefresh(task: BGAppRefreshTask) {
        // Schedule the next background task
        scheduleAppRefresh()

        // Perform background update for the Live Activity
        if let activity = Activity<FlightAttributes>.activities.first {
            Task {
                await activity.update(using: FlightAttributes.ContentState(
                    flightNumber: "AS8",
                    boardingGroup: "CD",
                    departureGate: "N8",
                    terminal: "N",
                    status: "BackgroundRefreshUpdate",
                    gateCloseTime: 8,
                    seat: "23D"
                ))
            }
        }

        task.setTaskCompleted(success: true)
    }

    // Schedule the next background refresh task
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.test.FlightTracker")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 5 * 60) // Schedule the next task in 5 minutes

        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh task: \(error.localizedDescription)")
        }
    }

    // Handle background fetch for Live Activity updates
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Background fetch triggered")

        // Perform background update for the Live Activity during fetch
        updateFlightActivityInBackground {
            completionHandler(.newData)
        }
    }

    func updateFlightActivityInBackground(completion: @escaping () -> Void) {
        // Simulate updating the Live Activity with new data
        if let activity = Activity<FlightAttributes>.activities.first {
            Task {
                let currentTime = Calendar.current.component(.minute, from: Date())
                await activity.update(using: FlightAttributes.ContentState(
                    flightNumber: "AS8",
                    boardingGroup: "Y",
                    departureGate: "I8",
                    terminal: "V",
                    status: "Fetch \(currentTime)",
                    gateCloseTime: currentTime,
                    seat: "24E"
                ))
                completion() // Call completion when the update is done
            }
        } else {
            completion() // Call completion if no activity found
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App entered background, scheduling background task")
        scheduleAppRefresh()
    }
}
