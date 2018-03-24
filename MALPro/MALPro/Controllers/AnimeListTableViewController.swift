//
//  AnimeListTableViewController.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

class AnimeListTableViewController: UITableViewController {
    
    let ROW_HEIGHT = 120.0 as CGFloat
    
    var networkingController = MALNetworkController()
    var animeList: AnimeList?
    var listType: AnimeStatus?
    
    init(animeList: AnimeList, listType: AnimeStatus) {
        self.animeList = animeList
        self.listType = listType
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = ROW_HEIGHT
        self.tableView.register(UINib(nibName: "AnimeTableViewCell", bundle: nil), forCellReuseIdentifier: "AnimeTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = listType?.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAnimeArray().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeTableViewCell", for: indexPath) as! AnimeTableViewCell
        let anime = getAnimeArray()[indexPath.row]
        if nil == anime.image {
            networkingController.getImage(url: anime.imageUrl!) { image in
                anime.image = image
                self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
        }

        cell.setUpCellForAnime(anime: anime)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let anime = getAnimeArray()[indexPath.row]
        let viewController = AnimeViewController(anime: anime)

        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private Helper Methods

    private func getAnimeArray() -> [Anime] {
        switch listType! {
            case .watching:
                return animeList!.watching
            case .onHold:
                return animeList!.onHold
            case .dropped:
                return animeList!.dropped
            case .planToWatch:
                return animeList!.planToWatch
            case .completed:
                return animeList!.completed
            default:
                return []
        }
    }
}
