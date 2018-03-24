//
//  File.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import Foundation
import UIKit
import KYDrawerController

class MALTabBarController: UITabBarController {
    
    var animeList = AnimeList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = getMenuBarButtonItem()
        
        setUpViewControllers()
        
        let neworkController = MALNetworkController()
        neworkController.getAnime(id: 1) { anime in
            guard let anime = anime else {
                return
            }
            self.animeList.addToList(listType: .watching, value: anime)
            (self.viewControllers![0] as! AnimeListTableViewController).tableView.reloadData()
        }
    }

    @objc func didTapOpenButton(sender: UIBarButtonItem) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    private func setUpViewControllers() {
        let watchingController = createAnimeListTableViewController(listType:.watching, tag: 0)
        let completed = createAnimeListTableViewController(listType: .completed, tag: 1)
        let onHold = createAnimeListTableViewController(listType: .onHold, tag: 2)
        let dropped = createAnimeListTableViewController(listType: .dropped, tag: 3)
        let planToWatch = createAnimeListTableViewController(listType: .planToWatch, tag: 4)
        
        viewControllers = [watchingController, completed, onHold, dropped, planToWatch]
    }
    
    private func createAnimeListTableViewController(listType: AnimeStatus, tag: NSInteger) -> AnimeListTableViewController {
        let viewController = AnimeListTableViewController(animeList: animeList, listType: listType)
        viewController.tabBarItem = UITabBarItem(title: listType.rawValue, image: getTabBarImage(listType: listType), tag: tag)
        return viewController
    }
    
    private func getMenuBarButtonItem() -> UIBarButtonItem {
        let image = UIImage(named: "DrawerMenuIcon");
        return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapOpenButton))
    }
    
    private func getTabBarImage(listType: AnimeStatus) -> UIImage {
        switch listType {
            case .watching:
                return UIImage(named: "WatchingTabBarIcon")!
            case .onHold:
                return UIImage(named: "OnHoldTabBarIcon")!
            case .dropped:
                return UIImage(named: "DroppedTabBarIcon")!
            case .planToWatch:
                return UIImage(named: "PlanToWatchTabBarIcon")!
            case .completed:
                return UIImage(named: "CompletedTabBarIcon")!
            default:
                return UIImage()
        }
    }
}
