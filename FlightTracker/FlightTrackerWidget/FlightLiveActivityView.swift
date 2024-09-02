//
//  FlightLiveActivityView.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 6/25/24.
//

import Foundation
import WidgetKit

import SwiftUI
import ActivityKit

struct FlightLiveActivityView: View {
    let context: ActivityViewContext<FlightAttributes>

    var body: some View {
        VStack(alignment: .leading) {
                    HStack {
                        Image("Alaska") // Replace "yourAirplaneLogo" with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30) // Adjust width as needed
                            .padding(.trailing, 8)
                        Spacer()
                        Image("AS")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(context.state.flightNumber)
                            .font(.headline)
                            .padding(.leading, 8)
                    }
                    .padding(16)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Group \(context.state.boardingGroup) now boarding")
                                .font(.headline)
                            Text("Departing from Gate \(context.state.departureGate), Terminal \(context.state.terminal)")
                        }
                        Spacer()
                        Text(context.state.status)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule()
                                            .fill(Color.cyan)
                                    )
                                    .foregroundColor(.white)
                    }
                    .padding(8)
                    VStack(alignment: .leading) {
                                    HStack {
                                        Text("Gate closes in \(context.state.gateCloseTime) min")
                                        Spacer()
                                        Text("Group \(context.state.boardingGroup) \u{2022} Seat \(context.state.seat)")
                                    }

                        }
                        .padding(16)
                        .background(Color.green.opacity(0.8))

                }
//        .padding(8)
        .background(Color.white.opacity(0.8))
//        VStack {
//            HStack {
//                Text(context.state.departureCode)
//                    .font(.headline)
//                    .padding(.trailing, 8)
//
//                DottedLine()
//                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                    .frame(height: 1)
//                    .foregroundColor(.gray)
//                    .padding(.horizontal, 8)
//
//                Image(systemName: "airplane")
//                    .font(.title)
//                    .padding(.horizontal, 8)
//
//                DottedLine()
//                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                    .frame(height: 1)
//                    .foregroundColor(.gray)
//                    .padding(.horizontal, 8)
//
//                Text(context.state.arrivalCode)
//                    .font(.headline)
//                    .padding(.leading, 8)
//            }
//            .padding(.bottom, 16)
//
//            HStack {
//                Image(systemName: "clock")
//                    .font(.title)
//                    .padding(.trailing, 4)
//                VStack(alignment: .leading) {
//                    Text("Departure: \(context.state.departureTime, formatter: dateFormatter)")
//                    Text("Arrival: \(context.state.arrivalTime, formatter: dateFormatter)")
//                }
//            }
//
//            Text("Status: \(context.state.status)")
//                .padding(.top, 8)
//        }
//        .padding()
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        return formatter
    }
}

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

//struct FlightLiveActivityView: View {
//    let context: ActivityViewContext<FlightAttributes>
//
//    var body: some View {
//        VStack {
//            HStack {
//                Image(systemName: "airplane")
//                    .font(.largeTitle)
//                    .padding(.trailing, 8)
//                VStack(alignment: .leading) {
//                    Text("Airline: \(context.attributes.airline)")
//                    Text("Flight Number: \(context.state.flightNumber)")
//                }
//            }
//            HStack {
//                Image(systemName: "clock")
//                    .font(.title)
//                    .padding(.trailing, 4)
//                VStack(alignment: .leading) {
//                    Text("Departure: \(context.state.departureTime, formatter: dateFormatter)")
//                    Text("Arrival: \(context.state.arrivalTime, formatter: dateFormatter)")
//                }
//            }
//            Text("Status: \(context.state.status)")
//        }
//        .padding()
//    }
//
//    private var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        formatter.dateStyle = .short
//        return formatter
//    }
//}
