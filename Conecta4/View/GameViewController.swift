//
//  GameViewController.swift
//  Conecta4
//
//  Created by Christian León Pérez Serapio on 04/01/22.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet private var columnStackView: [UIStackView]!
    @IBOutlet private var discImageView: [UIImageView]!
    @IBOutlet private var redPlayerScoreLabel: UILabel!
    @IBOutlet private var yellowPlayerScoreLabel: UILabel!
    
    let game = Game(board: Board(rows: 6, columns: 7))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        columnStackView.forEach {
            let tap = UITapGestureRecognizer(target: self,
                                             action: #selector(rowSelected(_:)))
            $0.addGestureRecognizer(tap)
        }
        updateScore()
    }
    
    @IBAction func selectRestartButton(_ sender: UIButton) {
        cleanScore()
    }
    
    @IBAction func selectCleanButton(_ sender: UIButton) {
        restartGame()
    }
    
    @objc func rowSelected(_ sender: UITapGestureRecognizer) {
        guard let column = sender.view?.tag else { return }
        let color: UIColor = game.turn == .yellow ? .yellow : .red
        if let position = game.setDiscOnBoard(atColumn: column) {
            let index = 7 * (position.row) + (position.column)
            discImageView[index].tintColor = color
        }
        if game.isShowingWinner {
            updateScore()
            showWinner()
        }
    }
    
    func updateScore() {
        redPlayerScoreLabel.text = "Red Player:\n\(game.score.red)"
        yellowPlayerScoreLabel.text = "Yellow Player:\n\(game.score.yellow)"
    }
    
    func restartGame() {
        game.setupGame()
        discImageView.forEach { $0.tintColor = .systemBackground }
    }
    
    func cleanScore() {
        game.cleanScore()
        updateScore()
        restartGame()
    }
    
    func showWinner() {
        let winner = game.currentWinner
        let alert = UIAlertController(title: "Game Over", message: winner, preferredStyle: .alert)
        let playAction = UIAlertAction(title: "Play again!", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.restartGame()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(playAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}


