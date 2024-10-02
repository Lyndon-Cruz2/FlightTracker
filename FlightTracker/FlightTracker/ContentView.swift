//
//  ContentView.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 6/25/24.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var activityId: String?
    @State private var flightAttributes: FlightAttributes?
    @State private var isFlightStarted = false

    var body: some View {
        VStack(spacing: 20) {
            Button("Start Flight Activity") {
                startFlightActivity()
            }
            .disabled(isFlightStarted)

            if isFlightStarted {
                Button("Update Flight Activity") {
                    guard let activityId = activityId else { return }
                    updateFlightActivity(activityId: activityId)
                }

                Button("End Flight Activity") {
                    guard let activityId = activityId else { return }
                    endFlightActivity(activityId: activityId)
                }
            }
        }
        .padding()
    }

    func startFlightActivity() {
        let attributes = FlightAttributes(airline: "Alaska Airlines")
        let initialContentState = FlightAttributes.ContentState(
            flightNumber: "AS1019",
            boardingGroup: "I",
            departureGate: "N88",
            terminal: "N",
            status: "ON TIME",
            gateCloseTime: 19,
            seat: "21I"
        )

        do {
            print("lyndon")
            let activity = try Activity<FlightAttributes>.request(
                attributes: attributes,
                contentState: initialContentState,
                pushType: nil
            )
            print("Requested a flight live activity with id: \(activity.id)")
            self.activityId = activity.id
            self.isFlightStarted = true
        } catch {
            print("Error requesting live activity: \(error.localizedDescription)")
        }
    }

    func updateFlightActivity(activityId: String) {
        Task {
            if let activity = Activity<FlightAttributes>.activities.first(where: { $0.id == activityId }) {
                await activity.update(using: FlightAttributes.ContentState(
                    flightNumber: "AS2381",
                    boardingGroup: "C",
                    departureGate: "N7",
                    terminal: "N",
                    status: "Delayed",  // Simulating an update
                    gateCloseTime: 15,
                    seat: "22D"
                ))
            }
        }
    }

    func endFlightActivity(activityId: String) {
        Task {
            if let activity = Activity<FlightAttributes>.activities.first(where: { $0.id == activityId }) {
                await activity.end(dismissalPolicy: .immediate)
                self.isFlightStarted = false
            }
        }
    }
}



