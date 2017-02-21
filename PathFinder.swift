//
//  PathFinder.swift
//  MatrixCalculation
//
//  Created by Ragunath Rajagopal on 21/02/17.
//  Copyright © 2017 Ragunath Rajagopal. All rights reserved.
//


import Foundation

/**
 * Calculates the path of least resistance from a grid.
 */
class PathFinder {
    
    init() {
    }
    
    /**
     * Calculates the path of least resistance from a grid.
     * - parameter grid: The input grid
     * - returns: Tuple of (success, least path resistance, least path)
     */
    func find(_ grid: Array<Array<Int>>) -> (Bool, Int, Array<Int>) {
        if grid.count==0 {
            return (false, 0, [])
        }
        
        // Calculate the least path starting at each row and choose the
        // of the results.
        let g = Grid(grid)
        var least: (Bool, Int, Array<Int>)! = nil
        for row in 1...g.rows {
            let rowLeast = findFrom(g, 0, [], (row, 1))
            if (least == nil || rowLeast.1 < least.1) {
                least = rowLeast
            }
        }
        
        return least
    }
    
    /**
     * Recursive helper method that calculates the least path from a given starting point.
     * - parameter g: The grid
     * - parameter prevResistance: The resistance up to this point
     * - parameter prevPath: The path up to this point
     * - parameter coords: The coordinates of this point
     */
    fileprivate func findFrom(_ g: Grid, _ prevResistance: Int, _ prevPath: Array<Int>, _ coords: (Int, Int)) -> (Bool, Int, Array<Int>) {
        // Add the current point to the previous path.
        let resistance = prevResistance + g.get(coords)
        let (r, c) = coords
        let path = prevPath + [r]
        
        // Base cases that stop the recursion.
        if resistance > 50 {
            return (false, prevResistance, prevPath)
        } else if c == g.columns {
            return (true, resistance, path)
        }
        
        // Calulate all possible paths from this point.
        let up = findFrom(g, resistance, path, g.up(coords))
        let right = findFrom(g, resistance, path, g.right(coords))
        let down = findFrom(g, resistance, path, g.down(coords))
        
        // Choose the least path from this point.
        if betterThan(up, right) && betterThan(up, down) {
            return up
        } else if betterThan(right, down) {
            return right
        } else {
            return down
        }
    }
    
    /**
     * Determines whether the result on the left is better (lesser path) than the result on
     * the right.
     * - parameter lhs: The left hand side
     * - parameter rhs: The right hand side
     */
    fileprivate func betterThan(_ lhs: (Bool, Int, Array<Int>), _ rhs: (Bool, Int, Array<Int>)) -> Bool {
        if lhs.2.count != rhs.2.count {
            return lhs.2.count > rhs.2.count
        } else {
            return lhs.1 <= rhs.1
        }
    }
    
}
