//
//  File.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation
import UIKit

class MALTabBarController: UITabBarController {
    
    var animeList: AnimeList!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeList = getAnimeList()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapOpenButton))
        
        setUpViewControllers()
    }

    @objc func didTapOpenButton(sender: UIBarButtonItem) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    private func setUpViewControllers() {
        let watchingController = createAnimeListTableViewController(listType: AnimeListType.watching, tag: 0)
        let completed = createAnimeListTableViewController(listType: AnimeListType.completed, tag: 1)
        let onHold = createAnimeListTableViewController(listType: AnimeListType.onHold, tag: 2)
        let dropped = createAnimeListTableViewController(listType: AnimeListType.dropped, tag: 3)
        let planToWatch = createAnimeListTableViewController(listType: AnimeListType.planToWatch, tag: 4)
        
        viewControllers = [watchingController, completed, onHold, dropped, planToWatch]
    }
    
    private func createAnimeListTableViewController(listType: AnimeListType, tag: NSInteger) -> AnimeListTableViewController {
        let viewController = AnimeListTableViewController(animeList: animeList, listType: listType)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: tag)
        return viewController
    }
    
    private func getAnimeList() -> AnimeList {
        var anime1 = Anime(id: 1)
        anime1.title = "K-ON!"
        anime1.episodeCount = 12
        let anime2 = Anime(id: 2)
        anime2.title = "Toradora"
        anime2.episodeCount = 25
        let completed = [anime1, anime2]
        
        anime1 = Anime(id: 3)
        anime1.title = "Clannad"
        anime1.episodeCount = 25
        let onHold = [anime1]
        
        anime1 = Anime(id: 4)
        anime1.title = "Darling in the Franxx"
        anime1.episodeCount = 24
        let watching = [anime1]
        
        anime1 = Anime(id: 5)
        anime1.title = "Citrus"
        anime1.episodeCount = 12
        let dropped = [anime1]
        
        anime1 = Anime(id: 6)
        anime1.title = "Cowboy Bebop"
        anime1.episodeCount = 26
        let planToWatch = [anime1]
        
        return AnimeList(watching: watching, onHold: onHold, dropped: dropped, planToWatch: planToWatch, completed: completed)
    }
}
