//
//  Stream.swift
//  TWTest
//
//  Created by Ramil on 08/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import UIKit
import Alamofire

class Stream {
    var broadcasterName: String!
    var streamTitle: String!
    var streamViewerCount: Double!
    var streamImage: UIImage?
    var streamImageUrl: String!
    
    init(name: String, title: String, viewerCount: Double, imageUrl: String) {
        broadcasterName = name
        streamTitle = title
        streamViewerCount = viewerCount
        streamImageUrl = imageUrl
    }
    
    func downloadStreamImage(completed: @escaping DownloadComplete) {
        request(streamImageUrl).responseData { [weak self] (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self?.streamImage = image
                }
            }
            completed()
        }
    }
    
}
