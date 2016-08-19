//
//  TicTacToeBackgroundView.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 7/9/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable class TicTacToeBackgroundView : UIView {
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            
            let lineWidth = min(bounds.width, bounds.height) / 20
            let inset = lineWidth / 2
            context.setLineWidth(lineWidth)
            context.setFillColor(backgroundColor!.cgColor)
            context.fill(bounds)
            
            context.setLineCap(.round)
            context.setStrokeColor(tintColor.cgColor)
            
            let ratios : [CGFloat] = [0.333, 0.666]
            
            for ratio in ratios {
                context.move(to: CGPoint(x: inset, y: bounds.height * ratio))
                context.addLine(to: CGPoint(x: bounds.width - inset, y: bounds.height * ratio))
                context.move(to: CGPoint(x: bounds.width * ratio, y: inset))
                context.addLine(to: CGPoint(x: bounds.width * ratio, y: bounds.height - inset))
            }
            
            context.strokePath()
        }
    }
}
