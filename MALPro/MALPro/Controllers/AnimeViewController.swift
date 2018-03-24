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
        synopsis.text = anime.synopsis
        animeInfo.fillInfo(anime: anime)
        
        if  nil == anime.image {
            networkingController.getImage(url: anime.imageUrl!) { image in
                anime.image = image
                self.view.setNeedsDisplay()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let anime = anime else {
            return
        }
        
        if nil != anime.image {
            coverImage.image = anime.image
        }
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
                self.watchingStatus.titleLabel?.text = watchingValues[0]
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
    }
    
    @IBAction func progressClicked(_ sender: UIButton) {
        ActionSheetMultipleStringPicker.show(withTitle: "Progress", rows: [
            intArray(min: 0, max: anime!.episodeCount!)
            ], initialSelection: [0], doneBlock: {
                picker, indexes, values in
                
                print("values = \(values!)")
                let progressValues = values as! [Int]
                self.progress.titleLabel?.text = "\(progressValues[0])/\(self.anime!.episodeCount!)"
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
    }

    @IBAction func scoreClicked(_ sender: UIButton) {
        ActionSheetMultipleStringPicker.show(withTitle: "Rating", rows: [
            intArray(min: 1, max: 10)
            ], initialSelection: [0], doneBlock: {
                picker, indexes, values in
                
                print("values = \(values!)")
                let scoreValues = values as! [Int]
                self.scorePicker.titleLabel?.text = "\(scoreValues[0])/10"
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
        
    }
    
    //MARK: - Private Helper Methods
    
    private func intArray(min: Int, max: Int) -> [Int] {
        return [Int](min...max)
    }
}
