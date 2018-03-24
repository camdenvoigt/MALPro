//
//  AnimeTableViewCell.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var episodeProgress: UILabel!
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
        title.text = anime.title
        episodeProgress.text = "\(anime.episodesWatched ?? 0)/\(anime.episodeCount ?? 0) episodes"
        guard let image = anime.image else {
            return
        }
        coverImage.image = image
    }
}
