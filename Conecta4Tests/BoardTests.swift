//
//  BoardTests.swift
//  Conecta4Tests
//
//  Created by Christian León Pérez Serapio on 05/01/22.
//

import XCTest
@testable import Conecta4

class BoardTests: XCTestCase {
    var board: Board!

    override func setUpWithError() throws {
        board = Board(rows: 6, columns: 7)
    }
    
    func testCreateBoards() {
        let board67 = Board(rows: 6, columns: 7)
        let result67: [[Disc]] = [
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
        ]
        
        let board38 = Board(rows: 3, columns: 8)
        let result38: [[Disc]] = [
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty,.empty]
        ]
        
        XCTAssertEqual(board67.grid, result67)
        XCTAssertEqual(board38.grid, result38)
    }
    
    func testSetDiscAtColumns() {
        for column in 0...6 {
            board.setDisc(forColumn: column, forDisc: .red)
        }
        
        for column in 2...4 {
            board.setDisc(forColumn: column, forDisc: .yellow)
        }
        
        board.setDisc(forColumn: 3, forDisc: .red)
        board.setDisc(forColumn: 6, forDisc: .yellow)
        
        // Overflow column
        (0...100).forEach { _ in
            board.setDisc(forColumn: 0, forDisc: .red)
        }
        
        // Put 1 token on each column and keep trying out of range
        (0...100).forEach { column in
            board.setDisc(forColumn: column, forDisc: .red)
        }
        
        // Test for invalid columns
        board.setDisc(forColumn: 100, forDisc: .yellow)
        board.setDisc(forColumn: -5, forDisc: .yellow)
        board.setDisc(forColumn: 10000, forDisc: .yellow)
        
        let result: [[Disc]] = [
            [.red,.empty,.empty, .empty, .empty, .empty,.empty],
            [.red,.empty,.empty, .empty, .empty, .empty,.empty],
            [.red,.empty,.empty, .red,   .empty, .empty,.empty],
            [.red,.empty,.red,   .red,   .red,   .empty,.red  ],
            [.red,.red,  .yellow,.yellow,.yellow,.red,  .yellow],
            [.red,.red,  .red,   .red,   .red,   .red,  .red  ],
        ]
        
        XCTAssertEqual(board.grid, result)
    }
    
    func testClearBoard() {
        (0...100).forEach { _ in
            board.setDisc(forColumn: 0, forDisc: .yellow)
        }
        
        board.clearBoard()
        
        let result: [[Disc]] = [
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
        ]
        
        XCTAssertEqual(board.grid, result)
    }
    
}
