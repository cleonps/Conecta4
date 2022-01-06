//
//  GameTests.swift
//  Conecta4Tests
//
//  Created by Christian León Pérez Serapio on 05/01/22.
//

import XCTest
@testable import Conecta4

class GameTests: XCTestCase {
    var game: Game!
    
    override func setUpWithError() throws {
        let board = Board(rows: 6, columns: 7)
        game = Game(board: board)
    }
    
    func testTurns() {
        XCTAssertEqual(game.turn, Turn.red)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.yellow)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.red)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.yellow)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.red)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.yellow)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.red)
        
        // Overflow should fail to set next turn
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.red)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.red)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.turn, Turn.red)
    }
    
    func testStartNextGame() {
        XCTAssertEqual(game.turn, Turn.red)
        XCTAssertEqual(game.board.grid, Board(rows:6, columns: 7).grid)
        game.setupGame()
        XCTAssertEqual(game.turn, Turn.red)
        XCTAssertEqual(game.board.grid, Board(rows:6, columns: 7).grid)
    }

}
