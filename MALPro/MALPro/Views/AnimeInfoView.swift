//
//  AnimeInfoView.swift
//  MALPro
//
//  Created by Logan Heitz on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

class AnimeInfoView: NibView {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var studioLabel: UILabel!
    
    
    func fillInfo(anime: Anime) {
        typeLabel.text = typeString(type: anime.type!)
        episodeCountLabel.text = "\(anime.episodeCount!)"
        sourceLabel.text = sourceString(source: anime.source!)
        scoreLabel.text = "\(anime.score!)"
        rankLabel.text = "#\(anime.rank!)"
        popularityLabel.text = "#\(anime.popularity!)"
    }
    
    //MARK: - Private Helper Functions
    
    private func typeString(type: AnimeType) -> String {
        switch type {
        case .tv:
            return "TV"
        case .movie:
            return "Movie"
        case .ova:
            return "OVA"
        case .special:
            return "Special"
        case .music:
            return "Music"
        case .none:
            return ""
        }
    }
    
    private func sourceString(source: AnimeSourceType) -> String {
        switch source {
        case .original:
            return "Original"
        case .manga:
            return "Manga"
        case .novel:
            return "Novel"
        case .lightNovel:
            return "Light Novel"
        }
    }
}
