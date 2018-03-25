//
//  CharacterCollectionView.swift
//  MALPro
//
//  Created by Logan Heitz on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

class ImageCollectionView: UICollectionView, UICollectionViewDataSource {
    
    private let reuseIdentifier = "ImageCollectionViewCell"

    var collection: [ImageCollectible]?
    
    override func awakeFromNib() {
        setUpLayout()
        self.dataSource = self
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    private func setUpLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        self.collectionViewLayout = flowLayout
    }
    
    func setCollection(collection: [ImageCollectible]) {
        self.collection = collection
        self.reloadData()
        fetchImages()
    }
    
    //MARK: - UICollectionViewDataSource Methods

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let _ = collection else {
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collection = collection else {
            return 0
        }
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        let collectible = collection![indexPath.row]
        cell.setUpForImageCollectible(collectible: collectible)
        return cell
    }
    
    //MARK: - Private Helper Methods
    
    private func fetchImages() {
        guard let collection = collection else {
            return
        }
        
        let networkController = MALNetworkController.sharedInstance
        for var collectible in collection {
            if collectible.image != nil {
                continue
            }
            networkController.getImage(url: collectible.imageUrl!) { image in
                guard let image = image else {
                    return
                }
                collectible.image = image
                
                self.reloadData()
            }
        }
    }
}
