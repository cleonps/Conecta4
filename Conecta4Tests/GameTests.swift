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
    
    // Given a finished game, when a player wins, then the board should be blocked and a flag to show the winner must be true
    func testIsShowingWinner() {
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 3)
        XCTAssertTrue(game.isShowingWinner)
        
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.board.grid[4][0], .yellow)
        XCTAssertEqual(game.board.grid[3][0], .empty)
        XCTAssertTrue(game.isShowingWinner)
        
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.board.grid[4][0], .yellow)
        XCTAssertEqual(game.board.grid[3][0], .empty)
        XCTAssertTrue(game.isShowingWinner)
        
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.board.grid[4][0], .yellow)
        XCTAssertEqual(game.board.grid[3][0], .empty)
        XCTAssertTrue(game.isShowingWinner)
    }
    
    func testScore() {
        var currentScore: Score = Score(red: 0, yellow: 0)
        // Given a new game, when it starts, then the score should start at 0
        XCTAssertEqual(game.score, currentScore)
        
        // Given a finished game, when a player wins, then the score should increase
        currentScore.red += 1
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 3)
        XCTAssertEqual(game.score, currentScore)
        
        currentScore.red += 1
        game.setupGame()
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertEqual(game.score, currentScore)
        
        currentScore.yellow += 1
        game.setupGame()
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 0)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 1)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 2)
        game.setDiscOnBoard(atColumn: 5)
        game.setDiscOnBoard(atColumn: 3)
        game.setDiscOnBoard(atColumn: 5)
        game.setDiscOnBoard(atColumn: 3)
        XCTAssertEqual(game.score, currentScore)
        
        // Given a finished game, when the game is a draw, then the score should not change
        game.setupGame()
        drawHelper()
        XCTAssertEqual(game.score, currentScore)
        
        game.setupGame()
        drawHelper()
        XCTAssertEqual(game.score, currentScore)
    }
    
    func testBlockedBoardForFinishedGame() {
        // Given a finished game, when a player wins, then the board should be blocked
        var currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertNotEqual(currentBoardGrid, game.board.grid)
        currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 0)
        XCTAssertNotEqual(currentBoardGrid, game.board.grid)
        currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 1)
        XCTAssertNotEqual(currentBoardGrid, game.board.grid)
        currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 1)
        XCTAssertNotEqual(currentBoardGrid, game.board.grid)
        currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 2)
        XCTAssertNotEqual(currentBoardGrid, game.board.grid)
        currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 2)
        XCTAssertNotEqual(currentBoardGrid, game.board.grid)
        currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 3)
        XCTAssertNotEqual(currentBoardGrid, game.board.grid)
        // Game finished
        currentBoardGrid = game.board.grid
        game.setDiscOnBoard(atColumn: 1)
        XCTAssertEqual(game.board.grid, currentBoardGrid)
        game.setDiscOnBoard(atColumn: 3)
        XCTAssertEqual(game.board.grid, currentBoardGrid)
        game.setDiscOnBoard(atColumn: 5)
        XCTAssertEqual(game.board.grid, currentBoardGrid)
        
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
