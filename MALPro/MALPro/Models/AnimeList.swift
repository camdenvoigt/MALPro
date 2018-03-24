//
//  AnimeList.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

enum AnimeListType: String {
    case watching = "Watching"
    case onHold = "On Hold"
    case dropped = "Dropped"
    case planToWatch = "Plan to Watch"
    case completed = "Completed"
}

class AnimeList {
    var watching: [Anime]
    var onHold: [Anime]
    var dropped: [Anime]
    var planToWatch: [Anime]
    var completed: [Anime]
    
    init(watching: [Anime], onHold: [Anime], dropped: [Anime], planToWatch: [Anime], completed: [Anime]) {
        self.watching = watching
        self.onHold = onHold
        self.dropped = dropped
        self.planToWatch = planToWatch
        self.completed = completed
    }
}
