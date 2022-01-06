//
//  Board.swift
//  Conecta4
//
//  Created by Christian León Pérez Serapio on 04/01/22.
//

import Foundation

//enum BoardError: String, Error {
//    case columnFull = "Couldn't set this for current column"
//}

enum Disc {
    case red, yellow, empty
}

typealias Position = (x: Int, y: Int)

class Board {
    let columns: Int
    let rows: Int
    var grid = [[Disc]]()
    
    init(rows: Int, columns: Int) {
        self.columns = columns
        self.rows = rows
        clearGrid()
    }
    
    @discardableResult func setDisc(forColumn column: Int, forDisc disc: Disc) -> Bool {
        guard (0...columns-1).contains(column) else { return false }
        for row in (0...rows-1).reversed() {
            print("Current row: \(row) for col: \(column)")
            let position = Position(x: row, y: column)
            if checkForEmptyPosition(at: position) {
                setDisc(at: position, forDisc: disc)
                return true
            }
        }
        return false
    }
    
    func clearBoard() {
        clearGrid()
    }
}

private extension Board {
    func checkForEmptyPosition(at position: Position) -> Bool {
        grid[position.x][position.y] == .empty
    }
    
    func setDisc(at position: Position, forDisc disc: Disc) {
        grid[position.x][position.y] = disc
    }
    
    func clearGrid() {
        grid = [[Disc]](repeating: [Disc](repeating: .empty, count: columns), count: rows)
    }
}
