 //
//  GameCell.swift
//  TWTest
//
//  Created by Ramil on 07/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    func configureCell(_ game: Game) {
        if game.gameImage != nil {
            gameImageView.image = game.gameImage
            gameImageView.layer.cornerRadius = 10
            gameImageView.layer.masksToBounds = true
        }
    }
}
