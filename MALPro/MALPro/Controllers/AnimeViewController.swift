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
        AnimeStatus.planToWatch.rawValue,
        AnimeStatus.watching.rawValue,
        AnimeStatus.onHold.rawValue,
        AnimeStatus.dropped.rawValue,
        AnimeStatus.completed.rawValue
    ]
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var animeInfo: AnimeInfoView!
    @IBOutlet weak var watchingStatus: UIButton!
    @IBOutlet weak var progress: UIButton!
    @IBOutlet weak var scorePicker: UIButton!
    @IBOutlet weak var synopsis: UITextView!
    
    var networkingController = MALNetworkController()
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

        animeInfo.fillInfo(anime: anime)
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
        ActionSheetMultipleStringPicker.show(withTitle: "Watching Status", rows: [
            watchingStatusPickerData
            ], initialSelection: [0], doneBlock: {
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
        watchingStatus.titleLabel?.text = anime.userStatus!.rawValue
    }
    
    private func setProgressButtonText() {
        progress.titleLabel?.text = "\(anime.episodesWatched!)/\(self.anime!.episodeCount!)"
    }
    
    private func setScoreButtonText() {
        scorePicker.titleLabel?.text = "\(anime.userScore!)/10"
    }
}
