//
//  PictureCollectionViewCell.swift
//  MALPro
//
//  Created by Logan Heitz on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpForImageCollectible(collectible: ImageCollectible) {
        label.text = collectible.getLabel() ?? ""
        subLabel.text = collectible.getSubLabel() ?? ""
        
        guard let imageSource = collectible.image else {
            return
        }
        image.image = imageSource
    }
}
