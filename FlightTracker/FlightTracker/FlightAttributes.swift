//
//  FlightAttributes.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 6/25/24.
//

import Foundation
import ActivityKit

struct FlightAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
//        var flightNumber: String
//        var departureTime: Date
//        var arrivalTime: Date
//        var status: String
//        var departureCode: String
//        var arrivalCode: String
        var id = UUID()
        var flightNumber: String
        var boardingGroup: String
        var departureGate: String
        var terminal: String
        var status: String
        var gateCloseTime: Int
        var seat: String
    }

    var airline: String
}
