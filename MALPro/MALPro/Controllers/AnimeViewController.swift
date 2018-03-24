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
        AnimeListType.planToWatch.rawValue,
        AnimeListType.watching.rawValue,
        AnimeListType.onHold.rawValue,
        AnimeListType.dropped.rawValue,
        AnimeListType.completed.rawValue
    ]
    
    @IBOutlet weak var watchingStatus: UIButton!
    @IBOutlet weak var progress: UIButton!
    @IBOutlet weak var scorePicker: UIButton!
    
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

        // Do any additional setup after loading the view.
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
