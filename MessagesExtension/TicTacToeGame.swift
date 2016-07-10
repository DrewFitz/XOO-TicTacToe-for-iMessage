//
//  TicTacToeGame.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 6/30/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import Foundation

struct TicTacToeGame {
    enum Move : String {
        case none = "_"
        case circle = "o"
        case cross = "x"
    }
    
    var board : [Move]
    
    init() {
        board = [Move].init(repeating: .none, count: 9)
    }
    
    func winner() -> Move? {
        
        // Board Layout
        // 0 1 2
        // 3 4 5
        // 6 7 8
        let winningLines : [[Int]] = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
        
        let winningCircles = [Move].init(repeating: .circle, count: 3)
        let winningCrosses = [Move].init(repeating: .cross, count: 3)
        
        for line in winningLines {
            let moves = line.map { board[$0] }
            
            if moves.elementsEqual(winningCircles) {
                return .circle
            }
            if moves.elementsEqual(winningCrosses) {
                return .cross
            }
            
        }
        
        return nil
    }
    
    func nextMove() -> Move {
        let count = board.filter {$0 != .none} .count
        
        return [.cross, .circle][count % 2]
    }
    
    func toURLComponents() -> URLComponents {
        var componentString = ""
        for move in board {
            componentString.append(move.rawValue)
        }
        var components = URLComponents()
        components.scheme = "data"
        components.path = componentString
        return components
    }
    
    mutating func from(components: URLComponents) -> Bool {
        guard let componentString = components.path else {
            return false
        }
        var newBoard = [Move]()
        for character in componentString.characters {
            if let move = Move(rawValue: String(character)) {
                newBoard.append(move)
            } else {
                return false
            }
        }
        guard newBoard.count == 9 else {
            return false
        }
        board = newBoard
        return true
    }
}
