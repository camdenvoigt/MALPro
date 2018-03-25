//
//  CharacterCollectionView.swift
//  MALPro
//
//  Created by Logan Heitz on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

class ImageCollectionView: UIView, UICollectionViewDataSource {
    
    private let reuseIdentifier = "ImageCollectionViewCell"
    
    private var collectionView: UICollectionView?

    var collection: [ImageCollectible]?
    
    override func awakeFromNib() {
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView!.dataSource = self
        collectionView!.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.addSubview(collectionView!)
    }
    
    func setCollection(collection: [ImageCollectible]) {
        self.collection = collection
        collectionView!.reloadData()
        fetchImages()
    }
    
    func setDelegate(delegate: UICollectionViewDelegateFlowLayout) {
        collectionView!.delegate = delegate
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (!__CGSizeEqualToSize(self.bounds.size, self.intrinsicContentSize)) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    //MARK: - Private Helper Methods
    
    private func fetchImages() {
        guard let collection = collection else {
            return
        }
        
        let networkController = MALNetworkController()
        for (index, var collectible) in collection.enumerated() {
            if collectible.image != nil {
                continue
            }
            networkController.getImage(url: collectible.imageUrl!) { image in
                guard let image = image else {
                    return
                }
                collectible.image = image
                
                self.reloadItem(at: index)
            }
        }
    }
    
    private func reloadItem(at index: Int) {
        guard let collectionView = collectionView else {
            return
        }
        
        guard let indexPath = collectionView.indexPathForItem(at: CGPoint(x: 0, y: index)) else {
            return
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
}
