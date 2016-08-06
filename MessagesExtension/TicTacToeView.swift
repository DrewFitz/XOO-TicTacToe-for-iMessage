//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 7/6/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable class TicTacToeView : UIView {
    typealias Move = TicTacToeGame.Move
    
    private var _move : Move = .none
    
    var move : Move {
        get {
            return _move
        }
        set {
            if newValue != _move {
                _move = newValue
                setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            context.setFillColor(backgroundColor!.cgColor)
            context.fill(bounds)
            
            let halfBounds = bounds.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
            let center = CGPoint(x: halfBounds.width, y: halfBounds.height)
            drawMove(move, at: center, context: context)
        }
    }
    
    private func drawMove(_ move: Move, at point : CGPoint, context: CGContext) {
        
        context.setStrokeColor(tintColor!.cgColor)
        let width = min(bounds.width, bounds.height) / 15
        context.setLineWidth(width)
        
        switch move {
        case .circle:
            let radius = min(bounds.width, bounds.height) / 2.8
            context.addArc(centerX: point.x, y: point.y, radius: radius, startAngle: 0, endAngle: 2*3.15, clockwise: 0)
        case .cross:
            let offset = min(bounds.width, bounds.height) / 3
            context.moveTo(x: point.x - offset, y: point.y - offset)
            context.addLineTo(x: point.x + offset, y: point.y + offset)
            context.moveTo(x: point.x + offset, y: point.y - offset)
            context.addLineTo(x: point.x - offset, y: point.y + offset)
        case .none:
            return
        }
        
        context.strokePath()
        
    }
    
    override func prepareForInterfaceBuilder() {
        _move = .circle
    }
}
