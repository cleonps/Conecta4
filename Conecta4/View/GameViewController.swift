//
//  GameViewController.swift
//  Conecta4
//
//  Created by Christian León Pérez Serapio on 04/01/22.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet private var columnStackView: [UIStackView]!
    
    let game = Game(board: Board(rows: 6, columns: 7))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        columnStackView.forEach {
            let tap = UITapGestureRecognizer(target: self,
                                             action: #selector(rowSelected(_:)))
            $0.addGestureRecognizer(tap)
        }
    }
    
    @objc func rowSelected(_ sender: UITapGestureRecognizer) {
        guard let column = sender.view?.tag else { return }
        game.setDiscOnBoard(atColumn: column)
        if game.isShowingWinner {
            showWinner()
        }
    }
    
    func showWinner() {
        let winner = game.currentWinner
        let alert = UIAlertController(title: "Partida terminada", message: winner, preferredStyle: .alert)
        let action = UIAlertAction(title: "Jugar de nuevo", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.game.setupGame()
            print("New game")
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}


