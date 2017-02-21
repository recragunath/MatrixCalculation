//
//  InputParser.swift
//  MatrixCalculation
//
//  Created by Ragunath Rajagopal on 21/02/17.
//  Copyright © 2017 Ragunath Rajagopal. All rights reserved.
//

import Foundation

class InputParser {
    
    init() {
    }
    
    func parse(_ input: String) -> Array<Array<Int>> {
        var matrix: Array<Array<Int>> = []
        
        let rowStrings = input.components(separatedBy: "\n")
        for rowString in rowStrings {
            if rowString.isEmpty {
                break
            }
            let colStrings = rowString.components(separatedBy: " ")
            matrix.append(colStrings.map() { x in Int(x) ?? 0 })
        }
        
        // Validate that all rows in the grid have the same length
        var width: Int!
        for row in matrix {
            width = width ?? row.count
            if row.count != width {
                fatalError("All rows must have the same length")
            }
        }
        
        return matrix
    }

}
