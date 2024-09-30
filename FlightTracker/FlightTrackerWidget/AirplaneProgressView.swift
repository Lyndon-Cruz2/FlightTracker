//
//  AirplaneProgressView.swift
//  FlightTracker
//
//  Created by Lyndon Cruz on 9/27/24.
//

import SwiftUI

struct AirplaneProgressView: View {
    let progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                SolidLine()
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(height: 1)

                Image(systemName: "airplane")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .offset(x: progress * (geometry.size.width - 30))
            }
            .frame(height: 30)
        }
        .frame(height: 30)
    }
}

struct SolidLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
