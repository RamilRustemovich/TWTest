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
    
    // Huandler function to open stream in chosen app
    func openStream(_ stream: Stream) {
        let alert = UIAlertController(title: "Open stream in TWTest or in official Twitch app?", message: "Official Twitch app must be installed for later option", preferredStyle: .alert)
        let openInTWTestAction = UIAlertAction(title: "TWTest", style: .default) { [weak self] (action) in
            self?.performSegue(withIdentifier: "channelShowVC", sender: stream)
        }
        let openInTwitchAppAction = UIAlertAction(title: "Twitch", style: .default) { [weak self] (action) in
            self?.openStreamInTwitchApp(stream)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(openInTWTestAction)
        alert.addAction(openInTwitchAppAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "channelShowVC" else { return }
        guard let channelVC = segue.destination as? ChannelViewController else { return }
        guard let stream = sender as? Stream else { return }
        channelVC.stream = stream
    }
    
    // MARK: Mobile Deep Link
    func openStreamInTwitchApp(_ stream: Stream) {
        let streamString = twitchUrlStreamDeepLink + stream.broadcasterName
        
        if let streamUrl = URL(string: streamString) {
            if UIApplication.shared.canOpenURL(streamUrl) {
                UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
            }
        }
    }
}


extension StreamsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 
        return (streamsTableView.bounds.width / 16) * 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stream = StreamDataService.instance.streams[indexPath.row]
        openStream(stream)
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
