//
//  Game.swift
//  TWTest
//
//  Created by Ramil on 07/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import UIKit
import Alamofire

class Game {
    
    var gameName: String!
    var gameImageUrl: String!
    var gameImage: UIImage?
    
    init(name: String, imageURL: String) {
        self.gameName = name
        self.gameImageUrl = imageURL
    }
    
    func downloadGameImage(completed: @escaping DownloadComplete) {
        request(gameImageUrl).responseData { [weak self] (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self?.gameImage = image
                }
            }
            completed()
        }
    }
}
