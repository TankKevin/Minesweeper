//
//  Coordinate.swift
//  Minesweeper
//
//  Created by 谭凯文 on 2018/3/4.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import Foundation

struct Coordinate {
    static func indexFromCoordinate(row: Int, column: Int, ofScale scale: Int) -> Int? {
        return (column >= 0 && column < scale && row >= 0 && row < scale) ? row * scale + column : nil
    }
    
    var row: Int
    var column: Int
    
    init(fromIndex index: Int, ofScale scale: Int) {
        column = index % scale
        row = index / scale
    }
    init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
