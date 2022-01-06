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
    
    init(board: Board) {
        self.board = board
        setupGame()
    }
    
    func setupGame() {
        board.clearBoard()
        turn = .red
    }
    
    func setDiscOnBoard(atColumn column: Int) {
        board.setDisc(forColumn: column, forDisc: turn.getDisc()) ? turn.toggle() : nil
    }
    
}
