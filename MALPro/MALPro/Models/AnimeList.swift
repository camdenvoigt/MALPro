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
    
    init() {
        self.watching = []
        self.onHold = []
        self.dropped = []
        self.planToWatch = []
        self.completed = []
    }
    
    init(watching: [Anime], onHold: [Anime], dropped: [Anime], planToWatch: [Anime], completed: [Anime]) {
        self.watching = watching
        self.onHold = onHold
        self.dropped = dropped
        self.planToWatch = planToWatch
        self.completed = completed
    }
    
    func addToList(listType: AnimeListType, value: Anime) {
        switch listType {
        case .watching:
            watching.append(value)
        case .onHold:
            onHold.append(value)
        case .dropped:
            dropped.append(value)
        case .planToWatch:
            planToWatch.append(value)
        case .completed:
            completed.append(value)
        }
    }
    
    func addToList(listType: AnimeListType, values: [Anime]) {
        switch listType {
        case .watching:
            watching.append(contentsOf: values)
        case .onHold:
            onHold.append(contentsOf: values)
        case .dropped:
            dropped.append(contentsOf: values)
        case .planToWatch:
            planToWatch.append(contentsOf: values)
        case .completed:
            completed.append(contentsOf: values)
        }
    }
}
