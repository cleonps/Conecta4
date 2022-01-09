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
        let result67: [[Disc]] = getEmptyGrid()
        
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
        
        let result: [[Disc]] = getEmptyGrid()
        
        XCTAssertEqual(board.grid, result)
    }
    // Given a new board, when there are 4 discs in a row, then there are 4 connected
    func testIfConnect4InARow() {
        board.setDisc(forColumn: 0, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertTrue(board.verifyIfConnect4())
        
        board.clearBoard()
        board.setDisc(forColumn: 0, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .red)
        XCTAssertTrue(board.verifyIfConnect4())
        
        board.clearBoard()
        board.setDisc(forColumn: 0, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .yellow)
        XCTAssertTrue(board.verifyIfConnect4())
        
        board.clearBoard()
        board.setDisc(forColumn: 0, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 5, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 6, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 0, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 6, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 5, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .yellow)
        XCTAssertTrue(board.verifyIfConnect4())
    }
    
    // Given a new board, when there are 4 discs in a column, then there are 4 connected
    func testIfConnect4InAColumn() {
        let randomNumber = Int.random(in: 0...6)
        board.setDisc(forColumn: randomNumber, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: randomNumber, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: randomNumber, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: randomNumber, forDisc: .yellow)
        XCTAssertTrue(board.verifyIfConnect4())
        
        board.clearBoard()
        board.setDisc(forColumn: randomNumber, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: randomNumber, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: randomNumber, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: randomNumber, forDisc: .red)
        XCTAssertTrue(board.verifyIfConnect4())
        
        board.clearBoard()
        board.setDisc(forColumn: 0, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 0, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 0, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 0, forDisc: .yellow)
        XCTAssertTrue(board.verifyIfConnect4())
    }
    
    // Given a new board, when there are 4 discs in a top diagonal (left-top to bottom-right), then there are 4 connected and grid should get emptied again
    func testIfConnect4InATopDiagonal() {
        board.setDisc(forColumn: 6, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 5, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 5, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 0, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertTrue(board.verifyIfConnect4())
        //        0 0 0 0 0 0 0
        //        0 0 0 0 0 0 0
        //        0 0 0 r 0 0 0
        //        0 0 0 y r 0 0
        //        0 0 0 r y r 0
        //        y 0 0 r y y r
    }
    
    
    // Given a new board, when there are 4 discs in a bottom diagonal (left-bottom to top-right), then there are 4 connected and grid should get emptied again
    func testIfConnect4InABottomDiagonal() {
        board.setDisc(forColumn: 0, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 1, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 2, forDisc: .red)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 4, forDisc: .yellow)
        XCTAssertFalse(board.verifyIfConnect4())
        board.setDisc(forColumn: 3, forDisc: .red)
        XCTAssertTrue(board.verifyIfConnect4())
        //        0 0 0 0 0 0 0
        //        0 0 0 0 0 0 0
        //        0 0 0 r 0 0 0
        //        0 0 r y 0 0 0
        //        0 r y r 0 0 0
        //        r y y r y 0 0
    }
    
    func testIfBoardIsFull() {
        var fullBoard = getFullRandomGrid()
        fullBoard.reversed().forEach {
            for (index, element) in $0.enumerated() {
                board.setDisc(forColumn: index, forDisc: element)
            }
        }
        XCTAssert(board.verifyIfBoardIsFull())
        
        board.clearBoard()
        fullBoard = getFullRandomGrid()
        fullBoard.reversed().forEach {
            for (index, element) in $0.enumerated() {
                board.setDisc(forColumn: index, forDisc: element)
            }
        }
        XCTAssert(board.verifyIfBoardIsFull())
    }
    
    func getEmptyGrid() -> [[Disc]] {
        [
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
            [.empty,.empty,.empty,.empty,.empty,.empty,.empty],
        ]
    }
    
    func getFullRandomGrid() -> [[Disc]] {
        [[Disc]](repeating: [Disc](repeating: Disc.random(), count: 7), count: 6)
    }
}
