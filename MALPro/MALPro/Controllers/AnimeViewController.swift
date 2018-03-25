//
//  AnimeViewController.swift
//  MALPro
//
//  Created by Logan Heitz on 3/24/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class AnimeViewController: UIViewController {
    
    let watchingStatusPickerData = [
        AnimeStatus.notAdded.rawValue,
        AnimeStatus.planToWatch.rawValue,
        AnimeStatus.watching.rawValue,
        AnimeStatus.onHold.rawValue,
        AnimeStatus.dropped.rawValue,
        AnimeStatus.completed.rawValue
    ]
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var animeInfoView: AnimeInfoView!
    @IBOutlet weak var watchingStatusButton: UIButton!
    @IBOutlet weak var progressButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var synopsis: UITextView!
    @IBOutlet weak var characterCollection: ImageCollectionView!
    
    var networkingController = MALNetworkController.sharedInstance
    var anime: Anime!
    
    init(anime: Anime) {
        self.anime = anime
        super.init(nibName: "AnimeView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let anime = anime else {
            return
        }
        
        self.navigationItem.title = anime.title!
        updateView()
        setUpCharacterCollectionView()
        
        if  nil == anime.image {
            networkingController.getImage(url: anime.imageUrl!) { image in
                anime.image = image
                self.updateView()
            }
        }
        
        if !anime.allData {
            networkingController.getAnime(id: anime.id) { anime in
                guard let anime = anime else {
                    return
                }
                self.anime.updateAnimeFromAnime(anime: anime)
                self.updateView()
            }
        }
    }
    
    func updateView() {
        guard let anime = anime else {
            return
        }
        
        if nil != anime.image {
            coverImage.image = anime.image
        }
        
        if nil != anime.synopsis {
            synopsis.text = anime.synopsis
        }

        animeInfoView.fillInfo(anime: anime)
        setWatchingStatusButtonText()
        setProgressButtonText()
        setScoreButtonText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Picker Methods
    
    @IBAction func watchingStatusClicked(_ sender: UIButton) {
        let initialSelction = watchingStatusPickerData.index(of: anime.userStatus!.rawValue) ?? 0
        ActionSheetMultipleStringPicker.show(withTitle: "Watching Status", rows: [
            watchingStatusPickerData
            ], initialSelection: [initialSelction], doneBlock: {
                picker, indexes, values in
                
                let watchingValues = values as! [String]
                //TODO: Actually launch request to change in MyAnimeList
                self.anime.userStatus = AnimeStatus(rawValue: watchingValues[0])
                self.setWatchingStatusButtonText()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func progressClicked(_ sender: UIButton) {
        ActionSheetMultipleStringPicker.show(withTitle: "Progress", rows: [
            intArray(min: 0, max: anime!.episodeCount!)
            ], initialSelection: [anime.episodesWatched!], doneBlock: {
                picker, indexes, values in
                
                let progressValues = values as! [Int]
                //TODO: Actually launch request to change in MyAnimeList
                self.anime.episodesWatched = progressValues[0]
                self.setProgressButtonText()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }

    @IBAction func scoreClicked(_ sender: UIButton) {
        ActionSheetMultipleStringPicker.show(withTitle: "Rating", rows: [
            intArray(min: 1, max: 10)
            ], initialSelection: [anime.userScore!], doneBlock: {
                picker, indexes, values in
                
                let scoreValues = values as! [Int]
                //TODO: Actually launch request to change in MyAnimeList
                self.anime.userScore = scoreValues[0]
                self.setScoreButtonText()
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    //MARK: - Private Helper Methods
    
    private func intArray(min: Int, max: Int) -> [Int] {
        return [Int](min...max)
    }
    
    private func setWatchingStatusButtonText() {
        watchingStatusButton.setTitle(" \(anime.userStatus!.rawValue)", for: .normal)
    }
    
    private func setProgressButtonText() {
        progressButton.setTitle(" \(anime.episodesWatched!)/\(self.anime!.episodeCount!)", for: .normal)
    }
    
    private func setScoreButtonText() {
        scoreButton.setTitle(" \(anime.userScore!)/10", for: .normal)
    }
}

extension AnimeViewController: UICollectionViewDelegateFlowLayout {
    
    func setUpCharacterCollectionView() {
        characterCollection.setDelegate(delegate: self)
        
        networkingController.getAnimeCharacters(animeId: anime.id) { characters in
            guard let characters = characters else {
                return
            }
            self.anime.characters = characters
            self.characterCollection.setCollection(collection: characters)
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90.0, height: 170.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = anime!.characters![indexPath.row]
        print(character.name!)
    }
}
