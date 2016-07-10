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
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
            
            let space = context.colorSpace
            
//            let colors : [CIColor] = [
//                CIColor.init(red: 161.0/255, green: 247.0/255, blue: 247.0/255),
//                CIColor.init(red: 236.0/255, green: 0.000/255, blue: 236.0/255)
//            ]
            
            if backgroundColor == nil {
                backgroundColor = UIColor.clear()
            }
            
            let colors : [CIColor] = [CIColor.init(color: tintColor), CIColor.init(color: backgroundColor!)]
            
            var components = [CGFloat]()
            
            for color in colors {
                components.append(color.red)
                components.append(color.green)
                components.append(color.blue)
                components.append(color.alpha)
            }
            
            let locations : [CGFloat] = [0.0, 1.0]
            
            let gradient = CGGradient(colorComponentsSpace: space!, components: components, locations: locations, count: locations.count)
            
            let start = CGPoint(x: 0, y: 0)
            let end   = CGPoint(x: 0, y: bounds.size.height)
            let options : CGGradientDrawingOptions = [.drawsAfterEndLocation, .drawsBeforeStartLocation]
            context.drawLinearGradient(gradient!, start: start, end: end, options: options)
        }
    }
}
