//
//  AnimeList.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

class AnimeList {
    var watchingCount: Int
    var completedCount: Int
    var onHoldCount: Int
    var droppedCount: Int
    var planToWatchCount: Int
    var daysWatching: Double?
    var watching: [Anime]
    var onHold: [Anime]
    var dropped: [Anime]
    var planToWatch: [Anime]
    var completed: [Anime]
    
    init(watching: [Anime] = [], onHold: [Anime] = [], dropped: [Anime] = [], planToWatch: [Anime] = [], completed: [Anime] = []) {
        self.watching = watching
        self.watchingCount = watching.count
        self.onHold = onHold
        self.onHoldCount = onHold.count
        self.dropped = dropped
        self.droppedCount = dropped.count
        self.planToWatch = planToWatch
        self.planToWatchCount = planToWatch.count
        self.completed = completed
        self.completedCount = completed.count
    }
}
