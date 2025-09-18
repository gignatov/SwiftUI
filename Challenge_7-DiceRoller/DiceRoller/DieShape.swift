//
//  DieShape.swift
//  DiceRoller
//
//  Created by Georgi Ignatov on 8.08.25.
//

import SwiftUI

struct DieShape: Shape {
    let sides: Int
    
    func path(in rect: CGRect) -> Path {
        guard sides >= 3 else { return Path() }
        
        let smallerRectSide = min(rect.width, rect.height)
        let center = CGPoint(x: smallerRectSide / 2, y: smallerRectSide / 2)
        let angleAdjustment = .pi * 2 / Double(sides)
        
        var currentAngle = -CGFloat.pi / 2
        if sides % 2 == 0 {
            currentAngle -= CGFloat.pi / CGFloat(integerLiteral: sides)
        }
        
        var path = Path()
        var bottomEdge = 0.0
        
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        
        for _ in 0...sides {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let positionX = center.x * cosAngle
            let positionY = center.y * sinAngle
            
            path.addLine(to: CGPoint(x: positionX, y: positionY))
            
            if positionY > bottomEdge {
                bottomEdge = positionY
            }
            
            currentAngle += angleAdjustment
        }
        
        let transform = CGAffineTransform(translationX: center.x, y: center.y)
        return path.applying(transform)
    }
}

#Preview {
    DieShape(sides: 3)
}
