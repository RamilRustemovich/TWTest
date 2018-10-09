//
//  StreamsViewController.swift
//  TWTest
//
//  Created by Ramil on 08/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController {
    
    @IBOutlet weak var streamsTableView: UITableView!
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(game.gameName!)"
        
        streamsTableView.delegate = self
        streamsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StreamDataService.instance.downloadStreamsForGame(game) {
            for stream in StreamDataService.instance.streams {
                stream.downloadStreamImage { [weak self] in
                    self?.streamsTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        StreamDataService.instance.removeAllStreams()
    }
}

extension StreamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 
        return (streamsTableView.bounds.width / 16) * 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension StreamsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StreamDataService.instance.streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as? StreamCell else { return StreamCell() }
        
        let stream = StreamDataService.instance.streams[indexPath.row]
        cell.configureCell(stream)
        
        return cell
    }
}
