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
    
    func addToList(listType: AnimeStatus, value: Anime) {
        switch listType {
            case .watching:
                watching.append(value)
                watchingCount += 1
            case .onHold:
                onHold.append(value)
                onHoldCount += 1
            case .dropped:
                dropped.append(value)
                droppedCount += 1
            case .planToWatch:
                planToWatch.append(value)
                planToWatchCount += 1
            case .completed:
                completed.append(value)
                completedCount += 1
            case .notAdded:
                return
        }
    }
    
    func addToList(listType: AnimeStatus, values: [Anime]) {
        switch listType {
            case .watching:
                watching.append(contentsOf: values)
                watchingCount += values.count
            case .onHold:
                onHold.append(contentsOf: values)
                onHoldCount += values.count
            case .dropped:
                dropped.append(contentsOf: values)
                droppedCount += values.count
            case .planToWatch:
                planToWatch.append(contentsOf: values)
                planToWatchCount += values.count
            case .completed:
                completed.append(contentsOf: values)
                completedCount += values.count
            case .notAdded:
                return
        }
    }
}
