//
//  TicTacToeCollectionViewController.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 7/1/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import UIKit
import CoreGraphics

protocol ActiveGameViewControllerDelegate {
    func activeGameView(_ viewController: ActiveGameViewController, didSelectCellAt indexPath: IndexPath)
    func activeGameViewCancelledChoosing(_ viewController: ActiveGameViewController)
}

class ActiveGameViewController: UIViewController {
    var game : TicTacToeGame!
    var delegate : ActiveGameViewControllerDelegate?
    var readOnly : Bool = false
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var gradientView: GradientView!
    
    override func viewWillAppear(_ animated: Bool) {
        let index = UserDefaults.init().integer(forKey: "backgroundGradient")
        gradientView.gradient = ThemeStore.gradient(index)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if game.winner() != .none {
            animateMoves()
        }
    }
    
    @IBAction func doubleTwoTapGestureAction(sender:AnyObject) {
        let gradient = ThemeStore.nextGradient(gradient: gradientView.gradient)
        gradientView.gradient = gradient
        
        let index = ThemeStore.indexOf(gradient: gradient)
        let defaults = UserDefaults.init()
        defaults.set(index, forKey: "backgroundGradient")
        defaults.synchronize()
    }
        
    private func animateNext<T : Collection>(cells: [UICollectionViewCell], sequence : T)
        where T: Sequence, T.SubSequence == ArraySlice<Int>, T.Iterator.Element == Int {
        if let slot = sequence.first {
            UIView.animate(withDuration: 0.5, animations: {
                let cell = cells[slot]
                cell.alpha = 1
                }, completion: { success in
                    let next : ArraySlice<Int> = sequence.dropFirst(1)
                    self.animateNext(cells: cells, sequence: next)
            })
        }
    }
    
    func animateMoves() {
        var cells = collectionView.visibleCells
        
        // make sure the cells are in the proper order
        cells.sort {
            collectionView.indexPath(for: $0.0)!.row < collectionView.indexPath(for: $0.1)!.row
        }
        
        // hide all the cells
        let _ = cells.map { $0.alpha = 0 }
        
        animateNext(cells: cells, sequence: game.sequence)
    }
}

extension ActiveGameViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.board.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < game.board.count else { fatalError("out of bounds cell") }
        
        let move = game.board[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "display", for: indexPath)
        
        if let cell = cell as? TicTacToeCell {
            cell.move = move
        }
        
        return cell
    }
}

extension ActiveGameViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let noWinner = game.winner() == .none
        let spaceIsOpen = game.board[indexPath.row] == .none
        return spaceIsOpen && noWinner && !readOnly
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        game.addMove(at: indexPath.row)
        collectionView.reloadData()
        self.delegate?.activeGameView(self, didSelectCellAt: indexPath)
    }
}

extension CGPoint {
    
    func distanceTo(_ other: CGPoint) -> CGPoint {
        return CGPoint(x: x - other.x, y: y - other.y)
    }

    func fromViewSpace(_ originView: UIView, to ancestorView: UIView) -> CGPoint {
        var newPoint = self
        var currentView = originView
        
        while let superView = currentView.superview {
            newPoint = newPoint.distanceTo(superView.frame.origin)
            currentView = superView
            if superView == ancestorView {
                return newPoint
            }
        }
        
        return CGPoint.zero
    }
}

// adds drawing view heirarchy to image
extension ActiveGameViewController {
    func imageSnapshot() -> UIImage? {
        // following code courtesy of Stack Overflow:
        // http://stackoverflow.com/questions/4334233/how-to-capture-uiview-to-uiimage-without-loss-of-quality-on-retina-display
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(collectionView.superview!.bounds.size, true, 0.0)
        let newOrigin = collectionView.bounds.origin.fromViewSpace(collectionView, to: view)
        snapshot?.draw(at: newOrigin)
        let croppedSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedSnapshot
    }
}
