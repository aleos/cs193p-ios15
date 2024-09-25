//
//  StripesShape.swift
//  Set
//
//  Created by Alexander Ostrovsky on 23.07.2022.
//

import SwiftUI

struct StripesShape: Shape {
    let distance: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for x in stride(from: rect.minX, through: rect.maxX, by: distance) {
            path.move(to: CGPoint(x: x, y: rect.minY))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        return path
    }
}
