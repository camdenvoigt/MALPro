//
//  Anime.swift
//  MALPro
//
//  Created by Camden Voigt on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation

public class Anime {
    var id: Int
    var canonicalLink: URL?
    var title: String?
    var titleJapanese: String?
    var imageUrl: URL?
    var type: String?
    var source: String?
    var episodeCount: Int?
    var status: String?
    var airing: Bool?
    var airDate: String?
    var startDate: Date?
    var endDate: Date?
    var duration: String?
    var rating: String?
    var score: Double?
    var rank: Int?
    var popularity: Int?
    var members: Int?
    var favorites: Int?
    var synopsis: String?
    var background: String?
    var premiered: String?
    var broadcast: String?
    
    init(id: Int) {
        self.id = id
    }
}
