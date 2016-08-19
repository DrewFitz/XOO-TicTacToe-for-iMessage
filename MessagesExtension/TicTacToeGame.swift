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
    
    private var _board : [Move]
    
    var board : [Move] {
        get {
            return _board
        }
    }
    
    private var moveSequence : [Int]
    
    init() {
        _board = [Move].init(repeating: .none, count: 9)
        moveSequence = []
    }
    
    func winner() -> Move {
        
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
        
        return .none
    }
    
    func currentMoveNumber() -> Int {
        return board.filter {$0 != .none} .count
    }
    
    func nextMove() -> Move {
        let count = currentMoveNumber()
        
        return [.cross, .circle][count % 2]
    }
    
    mutating func addMove(at slot: Int) {
        _board[slot] = nextMove()
        moveSequence.append(slot)
    }
    
    func toURLComponents() -> URLComponents {
        let componentString = moveSequence.reduce("") { $0 + "\($1)" }
        
        var components = URLComponents()
        components.scheme = "data"
        components.path = componentString
        return components
    }
    
    mutating func from(components: URLComponents) -> Bool {
        let componentString = components.path
        // save the old board in case of error
        let oldBoard = _board
        _board = [Move].init(repeating: .none, count: 9)
        for character in componentString.characters {
            if let slot = Int.init(String(character)) {
                addMove(at: slot)
            } else {
                _board = oldBoard
                return false
            }
        }
        return true
    }
}
