//
//  Pie.swift
//  Memorize
//
//  Created by Alexander Ostrovsky on 26/9/2024.
//

import CoreGraphics
import SwiftUI

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    let clockwise = true
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let startAngle = startAngle - .degrees(90)
            let endAngle = endAngle - .degrees(90)
            
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            let start = CGPoint(
                x: center.x + radius * cos(startAngle.radians),
                y: center.y + radius * sin(startAngle.radians)
            )
            
            path.move(to: center)
            path.addLine(to: start)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: !clockwise
            )
            path.addLine(to: center)
        }
    }
}

#Preview {
    Pie(startAngle: .zero, endAngle: .degrees(250))
        .foregroundStyle(.teal)
}
