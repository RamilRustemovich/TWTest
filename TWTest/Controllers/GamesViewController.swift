//
//  ViewController.swift
//  TWTest
//
//  Created by Ramil on 06/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Games"
        
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GamesViewController.reloadData), for: .valueChanged)
        gamesCollectionView.insertSubview(refreshControl, at: 0)
        
        reloadData()
    }
    
    @objc func reloadData() {
        GameDataService.instance.downloadTopGames {
            for game in GameDataService.instance.games {
                game.downloadGameImage { [weak self] in
                    self?.gamesCollectionView.reloadData()
                    self?.loadingIndicator.stopAnimating()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    
}

extension GamesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GamesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameDataService.instance.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as? GameCell {
            let game = GameDataService.instance.games[indexPath.row]
            cell.configureCell(game)
            return cell
        } else {
            return GameCell()
        }
    }
}

extension GamesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (gamesCollectionView.bounds.width / 2) - 15
        let height = width * (4 / 3)
        
        return CGSize(width: width, height: height)
    }
}






