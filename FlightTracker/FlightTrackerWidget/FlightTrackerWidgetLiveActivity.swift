//
//  FlightTrackerWidgetLiveActivity.swift
//  FlightTrackerWidget
//
//  Created by Lyndon Cruz on 6/25/24.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct FlightTrackerLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightAttributes.self) { context in
            FlightLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Image("AS")
                            .font(.title)
                            .padding(.bottom, 4)

                        Text(context.state.terminal)
                            .font(.headline)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                            Image("Alaska") // Replace "yourAirplaneLogo" with your image name
                                                .resizable()
                                                .frame(width: 20, height: 20)
                            VStack(alignment: .leading) {
                                                Text(context.state.flightNumber)
                                                Text("Group \(context.state.boardingGroup)")
                            }
                    }
                }

            } compactLeading: {
                Text("Group \(context.state.boardingGroup)")
                                    Text(context.state.status)
            } compactTrailing: {
                Image(systemName: "airplane")
            } minimal: {
                Text(context.state.boardingGroup)
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }
}
