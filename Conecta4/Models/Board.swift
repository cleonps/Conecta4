//
//  Board.swift
//  Conecta4
//
//  Created by Christian León Pérez Serapio on 04/01/22.
//

import Foundation

enum Disc: Int {
    case red = 1
    case yellow = -1
    case empty = 0
    
    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Disc {
        [Disc.red, Disc.yellow].randomElement(using: &generator)!
    }

    static func random() -> Disc {
        var t = SystemRandomNumberGenerator()
        return Disc.random(using: &t)
    }
}

typealias Position = (row: Int, column: Int)

class Board {
    let columns: Int
    let rows: Int
    private(set) var grid = [[Disc]]()
    private var lastPosition = Position(row: 0, column: 0)
    
    init(rows: Int, columns: Int) {
        self.columns = columns
        self.rows = rows
        clearGrid()
    }
    
    @discardableResult func setDisc(forColumn column: Int, forDisc disc: Disc) -> Position? {
        guard (0...columns-1).contains(column) else { return nil }
        for row in (0...rows-1).reversed() {
            let position = Position(row: row, column: column)
            if isPositionEmpty(at: position) {
                setDisc(at: position, forDisc: disc)
                lastPosition = position
                return position
            }
        }
        return nil
    }
    
    func verifyIfConnect4() -> Bool {
        areFourInARow() || areFourInAColumn() || areFourInADiagonal()
    }
    
    func verifyIfBoardIsFull() -> Bool {
        grid.allSatisfy { $0.allSatisfy { abs($0.rawValue) == 1 } }
    }
    
    func clearBoard() {
        clearGrid()
    }
}

private extension Board {
    func isPositionEmpty(at position: Position) -> Bool {
        grid[position.row][position.column] == .empty
    }
    
    func setDisc(at position: Position, forDisc disc: Disc) {
        grid[position.row][position.column] = disc
    }
    
    func areFourInARow() -> Bool {
        let currentRow = grid[lastPosition.row].map { $0.rawValue }
        var rowResult = 0
        for element in currentRow {
            rowResult = rowResult.signum() == element ? rowResult + element : element
            if abs(rowResult) == 4 {
                return true
            }
        }
        return false
    }
    
    func areFourInAColumn() -> Bool {
        let currentColumn = grid.map { $0[lastPosition.column].rawValue }
        var columnResult = 0
        for element in currentColumn {
            columnResult = columnResult.signum() == element ? columnResult + element : element
            if abs(columnResult) == 4 {
                return true
            }
        }
        return false
    }
    
    func areFourInADiagonal() -> Bool {
        areFourInATopDiagonal() || areFourInABottomDiagonal()
    }
    
    func areFourInATopDiagonal() -> Bool {
        var currentDiagonal: Position = lastPosition
        var topDiagonalResult = 0
        let corners = [(3,0), (4,0), (5,0), (4,1), (5,1), (5,2), (0,4), (0,5), (1,5), (0,6), (1,6), (2,6)]
        let isCorner = corners.map { $0 == lastPosition }.reduce(false) { $0 || $1 }
        guard !isCorner else { return false }
        
        while currentDiagonal.row != 0 && currentDiagonal.column != 0 {
            currentDiagonal.row -= 1
            currentDiagonal.column -= 1
        }
        
        while currentDiagonal.row < rows && currentDiagonal.column < columns {
            topDiagonalResult = topDiagonalResult.signum() == grid[currentDiagonal.row][currentDiagonal.column].rawValue ?
                                topDiagonalResult + grid[currentDiagonal.row][currentDiagonal.column].rawValue :
                                grid[currentDiagonal.row][currentDiagonal.column].rawValue
            if abs(topDiagonalResult) == 4 {
                return true
            }
            currentDiagonal.row += 1
            currentDiagonal.column += 1
        }
                
        return false
    }
    
    func areFourInABottomDiagonal() -> Bool {
        var currentDiagonal: Position = lastPosition
        var bottomDiagonalResult = 0
        let corners = [(0,0), (1,0), (2,0), (0,1), (1,1), (0,2), (5,4), (5,5), (4,5), (5,6), (4,6), (3,6)]
        let isCorner = corners.map { $0 == lastPosition }.reduce(false) { $0 || $1 }
        guard !isCorner else { return false }
        
        while currentDiagonal.row != rows - 1 && currentDiagonal.column != 0 {
            currentDiagonal.row += 1
            currentDiagonal.column -= 1
        }
        
        while currentDiagonal.row >= 0 && currentDiagonal.column < columns {
            bottomDiagonalResult = bottomDiagonalResult.signum() == grid[currentDiagonal.row][currentDiagonal.column].rawValue ?
                                bottomDiagonalResult + grid[currentDiagonal.row][currentDiagonal.column].rawValue :
                                grid[currentDiagonal.row][currentDiagonal.column].rawValue
            if abs(bottomDiagonalResult) == 4 {
                return true
            }
            currentDiagonal.row -= 1
            currentDiagonal.column += 1
        }
                
        return false
    }
    
    
    func clearGrid() {
        grid = [[Disc]](repeating: [Disc](repeating: .empty, count: columns), count: rows)
        lastPosition = Position(row: 0, column: 0)
    }
}
