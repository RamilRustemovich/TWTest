//
//  StreamDataService.swift
//  TWTest
//
//  Created by Ramil on 08/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import Foundation
import Alamofire

class StreamDataService {
    static let instance = StreamDataService()
    var streams = [Stream]()
    
    func downloadStreamsForGame(_ game: Game, completed: @escaping DownloadComplete) {
        var viewerCountDouble: Double!
        var imageUrlString, nameString, titleString: String!
        
        let gameString = game.gameName.replacingOccurrences(of: " ", with: "+")
        let url = twitchURLstreamsBase + gameString + twitchUrlStreamsClientId
        
        request(url).responseJSON { [weak self] (response) in
            guard let JSON = response.result.value as? [String: Any] else { completed(); return }
            guard let streamsArray = JSON["streams"] as? [Dictionary<String, Any>], streamsArray.count > 0 else { completed(); return }
            for i in 0..<streamsArray.count {
                if let viewerCount = streamsArray[i]["viewers"] as? Double {
                    viewerCountDouble = viewerCount
                }
                
                if let imageDict = streamsArray[i]["preview"] as? [String: Any] {
                    if let imageUrl = imageDict["large"] as? String {
                        imageUrlString = imageUrl
                    }
                }
                
                if let channelDict = streamsArray[i]["channel"] as? [String: Any] {
                    if let name = channelDict["display_name"] as? String {
                        nameString = name
                    }
                    
                    if let title = channelDict["status"] as? String {
                        titleString = title
                    }
                }
                
                let stream = Stream(name: nameString, title: titleString, viewerCount: viewerCountDouble, imageUrl: imageUrlString)
                self?.streams.append(stream)
            }
            completed()
        }
    }
    
    func removeAllStreams() {
        streams.removeAll()
    }
}
