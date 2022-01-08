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
    
    func testTurnAndGridForNewGame() {
        XCTAssertEqual(game.turn, Turn.red)
        XCTAssertEqual(game.board.grid, Board(rows:6, columns: 7).grid)
        game.setupGame()
        XCTAssertEqual(game.turn, Turn.red)
        XCTAssertEqual(game.board.grid, Board(rows:6, columns: 7).grid)
    }
    
    func testScore() {
        var currentScore: Int = 0
        // Given a new game, when it starts, then the score should start at 0
        XCTAssertEqual(game.score, 0)
        
        // Given a finished game, when a player wins, then the score should increase
        currentScore += 1
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 3)
        XCTAssertEqual(game.score, currentScore)
        
        currentScore += 1
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.score, currentScore)
        
        currentScore += 1
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 3)
        XCTAssertEqual(game.score, currentScore)
        
        // Given a finished game, when the game is a draw, then the score should not change
        drawHelper()
        XCTAssertEqual(game.score, currentScore)
        
        drawHelper()
        XCTAssertEqual(game.score, currentScore)
    }
    
    func drawHelper() {
        for column in (0...7) {
            game.setDiscOnBoard(atColumn: column)
        }
        for column in (0...6).reversed() {
            game.setDiscOnBoard(atColumn: column)
        }
        for column in (0...6) {
            game.setDiscOnBoard(atColumn: column)
        }
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 3)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 5)
        game.setDiscOnBoard(atColumn: 4)
        
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 3)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 5)
        game.setDiscOnBoard(atColumn: 4)
        
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 6)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 4)
        game.setDiscOnBoard(atColumn: 3)
        game.setDiscOnBoard(atColumn: 6)
        game.setDiscOnBoard(atColumn: 5)
        game.setDiscOnBoard(atColumn: 0)
        
//        y r y r y r y
//        r y r y r y y
//        r y r y r y r
//        r y r y r y r
//        y r y r y r y
//        r y r y r y r
    }
}
