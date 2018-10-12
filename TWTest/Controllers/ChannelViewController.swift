//
//  ChannelViewController.swift
//  TWTest
//
//  Created by Ramil on 10/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import UIKit
import WebKit

class ChannelViewController: UIViewController {
    
    var stream: Stream!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        
        let urlString = twitchUrlChannel + stream.broadcasterName
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
