//
//  Constants.swift
//  TWTest
//
//  Created by Ramil on 07/10/2018.
//  Copyright © 2018 Ramil. All rights reserved.
//

import Foundation

let twitchUrlTopGames = "https://api.twitch.tv/kraken/games/top?limit=50&client_id=ldf0z7w37ki9guj2cgnjkfsyf482n0"

let twitchUrlStreamsBase = "https://api.twitch.tv/kraken/streams/?game="
let twitchUrlStreamsClientId = "&client_id=ldf0z7w37ki9guj2cgnjkfsyf482n0"

let twitchUrlChannel = "https://player.twitch.tv/?channel="

let twitchUrlStreamDeepLink = "twitch://open?tream="

typealias DownloadComplete = () -> ()
