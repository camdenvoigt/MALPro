//
//  AnimeTableViewCell.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeProgressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setUpCellForAnime(anime: Anime) {
        titleLabel.text = anime.title
        episodeProgressLabel.text = "\(anime.episodesWatched ?? 0)/\(anime.episodeCount ?? 0) episodes"
        scoreLabel.text = getScoreString(anime: anime)
        guard let image = anime.image else {
            return
        }
        coverImage.image = image
    }
    
    private func getScoreString(anime: Anime) -> String {
        guard let score = anime.userScore else {
            return ""
        }
        guard score > 0 else {
            return ""
        }
        return "Score: \(score)/10"
    }
}
