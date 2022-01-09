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

struct Score: Equatable {
    var red: Int
    var yellow: Int
    
    static func ==(lhs: Score, rhs: Score) -> Bool {
        return lhs.red == rhs.red && lhs.yellow == rhs.yellow
    }
}

class Game {
    var board: Board
    var turn: Turn = .red
    var score: Score = Score(red: 0, yellow: 0)
    var isShowingWinner = false {
        didSet {
            if board.verifyIfConnect4() {
                switch turn {
                case .red:
                    score.red += 1
                case .yellow:
                    score.yellow += 1
                }
            }
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
        let discWasSet = board.setDisc(forColumn: column, forDisc: turn.getDisc())
        isShowingWinner = board.verifyIfConnect4() || board.verifyIfBoardIsFull()
        changeTurn(discWasSet: discWasSet)
    }
    
    func changeTurn(discWasSet: Bool) {
        discWasSet && !isShowingWinner ? turn.toggle() : nil
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
