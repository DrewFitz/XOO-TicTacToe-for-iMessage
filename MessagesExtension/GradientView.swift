//
//  GradientView.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 7/6/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable class GradientView : UIView {
    
    var gradient : Gradient = ThemeStore.shared.defaultGradient {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            
            let space = context.colorSpace
                        
            if backgroundColor == nil {
                backgroundColor = UIColor.clear
            }
            
            let gradient = self.gradient.cgGradient(colorSpace: space!)
            
            let start = CGPoint(x: 0, y: 0)
            let end   = CGPoint(x: 0, y: bounds.size.height)
            let options : CGGradientDrawingOptions = [.drawsAfterEndLocation, .drawsBeforeStartLocation]
            context.drawLinearGradient(gradient!, start: start, end: end, options: options)
        }
    }
    
    override func prepareForInterfaceBuilder() {
        gradient = ThemeStore.shared.summerCitrusGradient
    }
}
