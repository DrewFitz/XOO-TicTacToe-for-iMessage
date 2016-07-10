//
//  CollectionViewGridLayout.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 7/1/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import UIKit

@IBDesignable class CollectionViewGridLayout: UICollectionViewLayout {

    @IBInspectable var rows : UInt = 0
    @IBInspectable var columns : UInt = 0
    @IBInspectable var spacing : CGFloat = 0
    
    private var containerSize : CGSize {
        get {
            return collectionView!.bounds.size
        }
    }
    
    var cellWidth : CGFloat {
        get {
            return (containerSize.width - (spacing * CGFloat(columns-1))) / CGFloat(columns)
        }
    }
    
    var cellHeight : CGFloat {
        get {
            return (containerSize.height - (spacing * CGFloat(rows-1))) / CGFloat(rows)
        }
    }
    
    private func indexPaths(in rect: CGRect) -> [IndexPath]? {
        var paths = [IndexPath]()
        for i in 0..<collectionView!.numberOfItems(inSection: 0) {
            paths.append(IndexPath(row: Int(i), section: 0))
        }
        return paths
    }
    
    override func collectionViewContentSize() -> CGSize {
        return containerSize
    }
        
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let paths = indexPaths(in: rect) {
            let attrs : [UICollectionViewLayoutAttributes] = paths.map { path in
                return layoutAttributesForItem(at: path)!
            }
            return attrs
        } else {
            return nil
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attr.frame = CGRect(x: 0, y: 0, width: cellWidth, height: cellHeight)
        let x = indexPath.row % Int(columns)
        let y = indexPath.row / Int(columns)
        let xPos = cellWidth * (CGFloat(x) + 0.5) + spacing * CGFloat(x)
        let yPos = cellHeight * (CGFloat(y) + 0.5) + spacing * CGFloat(y)
        let center = CGPoint(x: xPos, y: yPos)
        attr.center = center
        return attr
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
