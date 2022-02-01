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
    private var lastGameTurn: Turn = .yellow
    
    init(board: Board) {
        self.board = board
        setupGame()
    }
    
    func setupGame() {
        board.clearBoard()
        turn = lastGameTurn == .red ? .yellow : .red
        lastGameTurn.toggle()
        isShowingWinner = false
        currentWinner = ""
    }
    
    @discardableResult func setDiscOnBoard(atColumn column: Int) -> Position? {
        guard !isShowingWinner else { return nil }
        var discWasSet = false
        let result: Position? = board.setDisc(forColumn: column, forDisc: turn.getDisc())
        if let _ = result {
            discWasSet = true
        }
        isShowingWinner = board.verifyIfConnect4() || board.verifyIfBoardIsFull()
        changeTurn(discWasSet: discWasSet)
        return result
    }
    
    func cleanScore() {
        score = Score(red: 0, yellow: 0)
    }
    
    private func changeTurn(discWasSet: Bool) {
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
