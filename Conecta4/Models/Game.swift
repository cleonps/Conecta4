//
//  Game.swift
//  Conecta4
//
//  Created by Christian León Pérez Serapio on 05/01/22.
//

import Foundation

enum Turn {
    case red, yellow
    
    mutating func toggle() {
        switch self {
        case .red: self = .yellow
        case .yellow: self = .red
        }
    }
    
    func getDisc() -> Disc {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        }
    }
}

class Game {
    var board: Board
    var turn: Turn = .red
    var score: Int = 0
    var isShowingWinner = false {
        didSet {
            currentWinner = isShowingWinner ? sendWinner() : ""
        }
    }
    var currentWinner = ""
    
    init(board: Board) {
        self.board = board
        setupGame()
    }
    
    func setupGame() {
        board.clearBoard()
        turn = .red
        isShowingWinner = false
        currentWinner = ""
    }
    
    func setDiscOnBoard(atColumn column: Int) {
        guard !isShowingWinner else { return }
        board.setDisc(forColumn: column, forDisc: turn.getDisc()) ? turn.toggle() : nil
        isShowingWinner = board.verifyIfConnect4() || board.verifyIfBoardIsFull()
    }
    
    func sendWinner() -> String {
        guard board.verifyIfConnect4() else {
            return "It's a Tie"
        }
        switch turn {
        case .red:
            return "Winner is player red"
        case .yellow:
            return "Winer is player yellow"
        }
    }
}
