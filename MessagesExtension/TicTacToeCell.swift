//
//  LabelCollectionViewCell.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 6/30/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import UIKit

class TicTacToeCell: UICollectionViewCell {
    @IBOutlet weak var ticTacToeView : TicTacToeView?
    
    var move : TicTacToeView.Move {
        get {
            return ticTacToeView!.move
        }
        set {
            ticTacToeView?.move = newValue
        }
    }
}
