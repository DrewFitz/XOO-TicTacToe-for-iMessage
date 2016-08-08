//
//  ThemeStore.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 8/7/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import Foundation
import UIKit

struct Gradient {
    var colors : [UIColor]
    var locations : [Float]
    
    func cgGradient(colorSpace: CGColorSpace) -> CGGradient? {
        guard colors.count > 0 else { return nil }
        guard colors.count == locations.count else { return nil }
        
        let ciColors = colors.map { CIColor(color: $0) }
        let cgLocations = locations.map { CGFloat($0) }
        var components : [CGFloat] = []
        
        for color in ciColors {
            components.append(color.red)
            components.append(color.green)
            components.append(color.blue)
            components.append(color.alpha)
        }
        
        let gradient = CGGradient(colorComponentsSpace: colorSpace, components: components, locations: cgLocations, count: cgLocations.count)
        return gradient
    }
    
}

extension Gradient : Equatable {}

func == (lhs : Gradient, rhs : Gradient) -> Bool {
    return lhs.colors == rhs.colors && lhs.locations == rhs.locations
}

class ThemeStore {
    private init() {}
    
    static let defaultGradient =      Gradient(colors: [#colorLiteral(red: 0.4039215686, green: 0.9647058824, blue: 0.9843137255, alpha: 1),#colorLiteral(red: 0.9137254902, green: 0, blue: 0.9647058824, alpha: 1)], locations: [0.0, 1.0])
    static let lemonLimeGradient =    Gradient(colors: [#colorLiteral(red: 0.9703611771, green: 1, blue: 0.2817283163, alpha: 1),#colorLiteral(red: 0.3632602519, green: 1, blue: 0.3220928997, alpha: 1)], locations: [0.0, 1.0])
    static let hotCocoaGradient =     Gradient(colors: [#colorLiteral(red: 0.5958492772, green: 0.3511361466, blue: 0.07918373287, alpha: 1),#colorLiteral(red: 0.386931335, green: 0.06522992489, blue: 0.03257886878, alpha: 1)], locations: [0.0, 1.0])
    static let deepSeaGradient =      Gradient(colors: [#colorLiteral(red: 0.1431525946, green: 0.4145618975, blue: 0.7041897774, alpha: 1),#colorLiteral(red: 0.0693108514, green: 0, blue: 0.2353696823, alpha: 1)], locations: [0.0, 1.0])
    static let surfFoamGradient =     Gradient(colors: [#colorLiteral(red: 0.2202886641, green: 0.9593387842, blue: 0.7137563222, alpha: 1),#colorLiteral(red: 0.1741507955, green: 0.6179590043, blue: 0.9573417522, alpha: 1)], locations: [0.0, 1.0])
    static let summerCitrusGradient = Gradient(colors: [#colorLiteral(red: 0.9559464455, green: 0.7789601973, blue: 0.2778314948, alpha: 1),#colorLiteral(red: 0.8275612917, green: 0.1124813138, blue: 0.0562709244, alpha: 1)], locations: [0.0, 1.0])
    
    private static let gradients = [defaultGradient,
                                    lemonLimeGradient,
                                    hotCocoaGradient,
                                    deepSeaGradient,
                                    surfFoamGradient,
                                    summerCitrusGradient]

    static func gradient(_ index: Int) -> Gradient {
        return gradients[index] ?? defaultGradient
    }
    
    static func indexOf(gradient : Gradient) -> Int {
        return gradients.index(of: gradient) ?? 0
    }
    
    static func nextGradient(gradient: Gradient) -> Gradient {
        if gradient == gradients.last! {
            return defaultGradient
        }
        
        if let i = gradients.index(of: gradient) {
            return gradients[i+1]
        } else {
            return defaultGradient
        }
    }
}
